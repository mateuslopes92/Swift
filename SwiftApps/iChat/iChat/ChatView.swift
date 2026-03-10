//
//  MessageChatView.swift
//  iChat
//
//  Created by Mateus Lopes on 09/03/26.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                ForEach(viewModel.messages, id: \.self){ message in
                    MessageRow(message: message)
                }
            }
        }
    }
}

struct MessageRow: View {
    
    let message: Message
    
    var body: some View {
        Text(message.text)
    }
}

#Preview {
    ChatView()
}
