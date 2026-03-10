//
//  MessagesViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//

import Foundation
import Combine
import FirebaseAuth

class ConversationsViewModel: ObservableObject {
    func logout() {
        try? Auth.auth().signOut()
    }
}
