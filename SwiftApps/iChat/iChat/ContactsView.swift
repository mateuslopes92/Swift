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
            List(viewModel.contacts, id: \.self){contact in
                ContactRow(contact: contact)
            }
        }.onAppear {
            viewModel.fetchContacts()
        }
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
    }
}

#Preview {
    ContactsView()
}
