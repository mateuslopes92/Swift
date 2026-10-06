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
    
    private var handleEnabled = true
    
    init(conversationsRepository: ConversationsRepository){
        self.conversationsRepository = conversationsRepository
    }
    
    func getConverstions() {
        conversationsRepository.getConverstions(){ conversations in
            if self.handleEnabled {
                self.conversations = conversations
            }
        }
    }
    
    func handleEnabled(enabled: Bool){
        self.handleEnabled = enabled
    }
    
    func logout() {
        conversationsRepository.logout()
    }
}
