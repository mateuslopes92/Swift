//
//  ContactsRepository.swift
//  iChat
//
//  Created by Mateus Lopes on 28/09/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ContactsRepository {
    
    func fetchContacts(completion: @escaping ([Contact]) -> Void) {
        var contacts: [Contact] = []
        
        Firestore.firestore().collection("users")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        if Auth.auth().currentUser?.uid != document.documentID{
                            contacts.append(
                                Contact(
                                    uuid: document.documentID,
                                    name: document.data()["name"] as! String,
                                    profileUrl: document.data()["profileUrl"] as! String
                                )
                            )
                        }
                    }
                    
                    completion(contacts)
                }
            }
    }
}
