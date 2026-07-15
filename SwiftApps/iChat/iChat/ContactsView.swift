//
//  ContactsView.swift
//  iChat
//
//  Created by Mateus Lopes on 13/01/26.
//

import SwiftUI

struct ContactsView: View {
    @StateObject var viewModel = ContactsViewModel()
    
    var body: some View {
        VStack {
            if(viewModel.isLoading){
                ProgressView()
            }
            List(viewModel.contacts, id: \.self){contact in
                NavigationLink {
                    ChatView(toId: contact.uuid, username: contact.name)
                } label: {
                    ContactRow(contact: contact)
                }
            }
        }.onAppear {
            viewModel.fetchContacts()
        }
        .navigationTitle("Contacts")
    }
}

struct ContactRow: View {
    var contact: Contact
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: contact.profileUrl)){image in
                image.resizable().scaledToFit().clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            Text(contact.name)
        }
        .frame(width: .infinity)
    }
}

#Preview {
    ContactsView()
}
