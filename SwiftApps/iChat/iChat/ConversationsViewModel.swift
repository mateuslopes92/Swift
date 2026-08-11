//
//  MessagesViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class ConversationsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var conversations: [Contact] = []
    
    func getConverstions() {
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("last-messages")
            .document(fromId)
            .collection("contacts")
            .addSnapshotListener{ snapshot, error in
                if let changes = snapshot?.documentChanges {
                    for doc in changes {
                        if doc.type == .added {
                            let document = doc.document
                            
                            self.conversations.removeAll()
                            self.conversations.append(
                                Contact(
                                    uuid: document.documentID,
                                    name: document.data()["username"] as! String,
                                    profileUrl: document.data()["photoUrl"] as! String,
                                    lastMessage: document.data()["lastMessage"] as? String,
                                    timestamp: document.data()["timestamp"] as? UInt
                               )
                            )
                        }
                    }
                }
            }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}
