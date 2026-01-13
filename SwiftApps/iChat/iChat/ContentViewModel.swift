//
//  Untitled.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//

import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    @Published var isLogged = Auth.auth().currentUser != nil
}
