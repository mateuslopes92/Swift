//
//  SignInViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 01/11/25.
//
import Foundation
import Combine

class SignInViewModel: ObservableObject {
    var email: String = ""
    var password: String = ""
    
    func signIn(){
        print("email: \(email), password: \(password)")
    }
}
