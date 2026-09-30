//
//  ChatRepository.swift
//  iChat
//
//  Created by Mateus Lopes on 28/09/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatRepository {
    
    var myName: String = ""
    var myPhoto: String = ""
    let limit: Int = 20
    var inserting: Bool = false
    
    func fetchChat(contact: Contact, lastMessage: Message?, completion: @escaping ([Message], Int) -> Void){
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
        
        var messages: [Message] = []
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .order(by: "timestamp", descending: true)
            .limit(to: limit)
            .start(after: [lastMessage?.timestamp ?? 999999999999999])
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
                                messages.insert(message, at: 0)
                            } else {
                                messages.append(message)
                            }
                        }
                    }
                    self.inserting = false
                }
                
                let newCount = messages.count
                completion(messages, newCount)
            }
    }
    
    func sendMessage(inserting: Bool, text: String, contact: Contact){
        self.inserting = inserting
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
                        "lastMessage": text
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
                        "lastMessage": text
                    ])
                
            }
    }
}
