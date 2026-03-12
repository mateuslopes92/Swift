//
//  MessageChatView.swift
//  iChat
//
//  Created by Mateus Lopes on 09/03/26.
//

import SwiftUI

struct ChatView: View {
    let username: String
    
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                ForEach(viewModel.messages, id: \.self){ message in
                    MessageRow(message: message)
                }
            }
            
            Spacer()
            
            HStack{
                TextField("Type your message", text: $viewModel.text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(24.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24.0)
                            .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0))
                    )
                
                Button{
                    //
                } label: {
                    Text("Send")
                        .padding()
                        .background(Color("GreenColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(24.0)
                }
                .disabled(viewModel.text.isEmpty)
                
            }
            .padding(8.0)
        }
        .navigationTitle(username)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MessageRow: View {
    
    let message: Message
    
    var body: some View {
        Text(message.text)
            .background(Color(white: 0.95))
            .frame(maxWidth: .infinity, alignment: message.isMe ?  .leading : .trailing)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.leading, message.isMe ? 0 : 50)
            .padding(.trailing, message.isMe ? 50 : 0)
            .padding(.vertical, 4)
    }
}

#Preview {
    ChatView(username: "Test User")
}
