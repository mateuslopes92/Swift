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
    
    private let chatRepository: ChatRepository
    
    let limit: Int = 20
    var newCount = 0
    var inserting: Bool = false
    
    init(chatRepository: ChatRepository){
        self.chatRepository = chatRepository
    }
    
    func onAppear(contact: Contact){
        chatRepository.fetchChat(contact: contact, lastMessage: self.messages.last){ message in
            
            if self.inserting || message.timestamp > self.messages.last?.timestamp ?? 0 {
                self.messages.insert(message, at: 0)
            } else {
                self.messages.append(message)
            }
            
            self.inserting = false
            
            self.newCount = self.messages.count
        }
    }
    
    func sendMessage(contact: Contact){
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        newCount = newCount + 1
        self.text = ""
        self.inserting = true
        
        chatRepository.sendMessage(text: text, contact: contact)
    }
}
