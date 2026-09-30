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
    
    init(chatRepository: ChatRepository){
        self.chatRepository = chatRepository
    }
    
    func onAppear(contact: Contact){
        chatRepository.fetchChat(contact: contact, lastMessage: self.messages.last){ messages, newCount in
            self.messages.append(contentsOf: messages)
            self.newCount = newCount
        }
    }
    
    func sendMessage(contact: Contact){
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        newCount = newCount + 1
        self.text = ""
        
        chatRepository.sendMessage(inserting: true, text: text, contact: contact)
    }
}
