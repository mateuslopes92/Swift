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
    
    var myName: String = ""
    var myPhoto: String = ""
    
    let limit: Int = 20
    
    var inserting: Bool = false
    
    var newCount = 0
    
    func onAppear(contact: Contact){
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("users")
            .document(fromId)
            .getDocument { (snapshot, error) in
                if let error = error {
                    print("ERROR: Fetching documents \(error)")
                }
                
                if let document = snapshot?.data() {
                    self.myName = document["name"] as! String
                    self.myPhoto = document["profileUrl"] as! String
                }
            }
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .order(by: "timestamp", descending: true)
            .limit(to: limit)
            .start(after: [self.messages.last?.timestamp ?? 999999999999999])
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("ERROR: Fetching documents \(error)")
                }
                
                if let changes = querySnapshot?.documentChanges {
                    for doc in changes {
                        if doc.type == .added {
                            let document = doc.document
                            print("Document: \(document.documentID) \(document.data())")
                            
                            let message = Message(
                                uuid: document.documentID,
                                text: document.data()["text"] as! String,
                                isMe: fromId == document.data()["fromId"] as! String,
                                timestamp: document.data()["timestamp"] as! UInt
                            )
                            
                            if self.inserting {
                                self.messages.insert(message, at: 0)
                            } else {
                                self.messages.append(message)
                            }
                        }
                    }
                    self.inserting = false
                }
                self.newCount = self.messages.count
            }
    }
    
    func sendMessage(contact: Contact){
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        inserting = true
        newCount = newCount + 1
        self.text = ""
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .addDocument(data: [
                "fromId": fromId,
                "toId": contact.uuid,
                "text": text,
                "timestamp": UInt(timestamp)
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(fromId)
                    .collection("contacts")
                    .document(contact.uuid)
                    .setData([
                        "uid": contact.uuid,
                        "username": contact.name,
                        "photoUrl": contact.profileUrl,
                        "timestamp": UInt(timestamp),
                        "lastMessage": self.text
                    ])
            }
        
        Firestore.firestore().collection("conversations")
            .document(contact.uuid)
            .collection(fromId)
            .addDocument(data: [
                "fromId": fromId,
                "toId": contact.uuid,
                "text": text,
                "timestamp": UInt(timestamp)
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(contact.uuid)
                    .collection("contacts")
                    .document(fromId)
                    .setData([
                        "uid": fromId,
                        "username": self.myName,
                        "photoUrl": self.myPhoto,
                        "timestamp": UInt(timestamp),
                        "lastMessage": self.text
                    ])
                
            }
        
        //self.text = ""
    }
}
