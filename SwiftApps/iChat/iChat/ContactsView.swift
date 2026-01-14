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
                Text("Contact name: \(contact.name)")
            }
        }.onAppear {
            viewModel.fetchContacts()
        }
    }
}

#Preview {
    ContactsView()
}
