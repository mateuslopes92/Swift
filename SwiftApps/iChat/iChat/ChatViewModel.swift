//
//  MessageChatViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 09/03/26.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = [
        Message(uuid: UUID(), text: "Hello!", isMe: false),
        Message(uuid: UUID(), text: "Hello!", isMe: true),
        Message(uuid: UUID(), text: "How are you doing?", isMe: false),
        Message(uuid: UUID(), text: "All good?", isMe: false),
        Message(uuid: UUID(), text: "All good!", isMe: true),
        Message(uuid: UUID(), text: "asdasdasdajsfoajsfoiasfjioas asfjaiosfjioasjfij asjif ioasjfioas jioj!", isMe: false),
        Message(uuid: UUID(), text: "asdasdasd!", isMe: false),
    ]
    
    @Published var text = ""
}
