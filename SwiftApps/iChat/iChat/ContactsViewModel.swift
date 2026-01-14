//
//  Untitled.swift
//  iChat
//
//  Created by Mateus Lopes on 13/01/26.
//

import Foundation
import Combine
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    func fetchContacts() {
        Firestore.firestore().collection("users")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        self.contacts.append(
                            Contact(
                                uuid: document.documentID,
                                name: document.data()["name"] as! String,
                                profileUrl: document.data()["profileUrl"] as! String
                            )
                        )
                    }
                }
            }
    }
}
