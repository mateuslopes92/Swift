//
//  MessagesViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//

import Foundation
import Combine
import FirebaseAuth

class MessagesViewModel: ObservableObject {
    func logout() {
        try? Auth.auth().signOut()
    }
}
