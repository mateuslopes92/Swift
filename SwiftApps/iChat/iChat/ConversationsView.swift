//
//  MessagesView.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//

import SwiftUI

struct ConversationsView: View {
    @StateObject var viewModel = ConversationsViewModel()

    var body: some View {
        VStack {
            Text("Messages here")
        }.toolbar {
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

#Preview {
    ConversationsView()
}
