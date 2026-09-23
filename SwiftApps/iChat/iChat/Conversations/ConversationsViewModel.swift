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
    
    private let conversationsRepository: ConversationsRepository
    
    init(conversationsRepository: ConversationsRepository){
        self.conversationsRepository = conversationsRepository
    }
    
    func getConverstions() {
        conversationsRepository.getConverstions(){ conversations in
            self.conversations.removeAll()
            self.conversations = conversations
        }
    }
    
    func logout() {
        conversationsRepository.logout()
    }
}
