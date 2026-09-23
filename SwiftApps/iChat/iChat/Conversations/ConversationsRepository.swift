//
//  ConversationsRepository.swift
//  iChat
//
//  Created by Mateus Lopes on 22/09/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ConversationsRepository {
    
    
    func getConverstions(completion: @escaping ([Contact]) -> Void) {
        var conversations: [Contact] = []
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("last-messages")
            .document(fromId)
            .collection("contacts")
            .addSnapshotListener{ snapshot, error in
                if let changes = snapshot?.documentChanges {
                    for doc in changes {
                        if doc.type == .added {
                            let document = doc.document
                            
                            conversations.removeAll()
                            conversations.append(
                                Contact(
                                    uuid: document.documentID,
                                    name: document.data()["username"] as! String,
                                    profileUrl: document.data()["photoUrl"] as! String,
                                    lastMessage: document.data()["lastMessage"] as? String,
                                    timestamp: document.data()["timestamp"] as? UInt
                               )
                            )
                        }
                        completion(conversations)
                    }
                }
            }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}
