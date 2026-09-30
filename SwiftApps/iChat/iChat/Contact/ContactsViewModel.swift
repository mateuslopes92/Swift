//
//  Untitled.swift
//  iChat
//
//  Created by Mateus Lopes on 13/01/26.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var isLoading = false
    
    private let contactsRepository: ContactsRepository
    
    init(contactsRepository: ContactsRepository){
        self.contactsRepository = contactsRepository
    }
    
    var isLoaded = false
    
    func fetchContacts() {
        if isLoaded { return }
        isLoading = true
        
        contactsRepository.fetchContacts { contacts in
            self.contacts.append(contentsOf: contacts)
            self.isLoaded = true
            self.isLoading = false
        }
        
    }
}
