//
//  MessagesView.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//

import SwiftUI

struct ConversationsView: View {
    @StateObject var viewModel = ConversationsViewModel(conversationsRepository: ConversationsRepository())

    var body: some View {
        VStack {
            if viewModel.isLoading {
                    ProgressView()
            }
            
            List(viewModel.conversations, id: \.self){ contact in
                NavigationLink {
                    ChatView(contact: contact)
                } label: {
                    ContactConversationRow(contact: contact)
                }
            }
            
        }
        .onAppear{
            viewModel.getConverstions()
        }
        .navigationTitle("Chats")
        .toolbar {
            ToolbarItem(id: "contacts", placement: .topBarTrailing){
                NavigationLink("Contacts", destination: ContactsView())
            }
            ToolbarItem(id: "logout", placement: .topBarTrailing){
                Button("Logout"){
                    viewModel.logout()
                }
            }
        }
    }
}

struct ContactConversationRow: View {
    var contact: Contact
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: contact.profileUrl)){image in
                image.resizable().scaledToFit().clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(contact.name)
                
                if let msg = contact.lastMessage {
                    Text(msg)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
        }
        .frame(width: .infinity)
    }
}

#Preview {
    ConversationsView()
}
