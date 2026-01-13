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
        Button {
            viewModel.logout()
        } label: {
            Text("Logout")
        }
    }
}

#Preview {
    MessagesView()
}
