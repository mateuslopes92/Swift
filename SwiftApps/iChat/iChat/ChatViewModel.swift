//
//  MessageChatViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 09/03/26.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    
    @Published var text = ""
    
    func onAppear(toId: String){
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("ERROR: Fetching documents \(error)")
                }
                
                if let changes = querySnapshot?.documentChanges {
                    for doc in changes {
                        let document = doc.document
                        print("Document: \(document.documentID) \(document.data())")
                        
                        let message = Message(
                            uuid: document.documentID,
                            text: document.data()["text"] as! String,
                            isMe: fromId == document.data()["fromId"] as! String
                        )
                        
                        self.messages.append(message)
                    }
                }
            }
            
    }
    
    func sendMessage(toId: String){
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(toId)
            .addDocument(data: [
                "fromId": fromId,
                "toId": toId,
                "text": text,
                "timestamp": UInt(timestamp)
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        
        Firestore.firestore().collection("conversations")
            .document(toId)
            .collection(fromId)
            .addDocument(data: [
                "fromId": fromId,
                "toId": toId,
                "text": text,
                "timestamp": UInt(timestamp)
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
}
