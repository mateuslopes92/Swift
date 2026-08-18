//
//  MessageChatView.swift
//  iChat
//
//  Created by Mateus Lopes on 09/03/26.
//

import SwiftUI

struct ChatView: View {
    
    let contact: Contact
    
    @StateObject var viewModel = ChatViewModel()
    
    @State var textSize: CGSize = .zero
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                ForEach(viewModel.messages, id: \.self){ message in
                    MessageRow(message: message)
                }
            }
            
            Spacer()
            
            HStack{
                ZStack {
                    TextEditor(text: $viewModel.text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(24.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24.0)
                                .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0))
                        )
                        .frame(maxHeight: (textSize.height + 50) > 100 ? 100 : textSize.height + 50)
                    
                    Text(viewModel.text)
                        .opacity(0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(ViewGeometry())
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 21)
                        .onPreferenceChange(ViewSizeKey.self){ size in
                            textSize = size
                        }
                }
                Button{
                    viewModel.sendMessage(contact: contact)
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
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.onAppear(contact: contact)
        }
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color
                .clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .init(width: 0, height: 0)
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct MessageRow: View {
    
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(message.text)
                .padding(.vertical, 5)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 10)
                .background(Color(white: 0.95))
                .frame(maxWidth: 260, alignment: message.isMe ?  .trailing : .leading)
        }
        .frame(maxWidth: .infinity, alignment:  message.isMe ? .trailing : .leading)
    }
}

#Preview {
    ChatView(contact: Contact(uuid: UUID().uuidString, name: "Test user", profileUrl: "Fakeurl"))
}
