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
    
    func sendMessage(toId: String){
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(toId)
            .addDocument(data: [
                "fromId": fromId,
                "toId": toId,
                "text": text,
                "timestamp": UInt(timestamp)
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        
        Firestore.firestore().collection("conversations")
            .document(toId)
            .collection(fromId)
            .addDocument(data: [
                "fromId": fromId,
                "toId": toId,
                "text": text,
                "timestamp": UInt(timestamp)
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
}
