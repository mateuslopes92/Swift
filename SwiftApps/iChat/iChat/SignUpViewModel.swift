//
//  SignUpViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 03/11/25.
//
import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    func signUp(){
        print("name: \(name) email: \(email), password: \(password)")
    }
}

