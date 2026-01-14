//
//  MessagesView.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//

import SwiftUI

struct MessagesView: View {
    @StateObject var viewModel = MessagesViewModel()
    
    var body: some View {
        NavigationView {
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
}

#Preview {
    MessagesView()
}
