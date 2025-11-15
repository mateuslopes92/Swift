//
//  SignUpViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 03/11/25.
//
import Foundation
import Combine
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    @Published var formInvalid: Bool = false
    var alertText: String = ""
    
    func signUp(){
        print("name: \(name) email: \(email), password: \(password)")
        Auth.auth().createUser(withEmail: email, password: password) {
            result, err in
            
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err?.localizedDescription ?? "Unknown Error"
                print(err?.localizedDescription)
                return
            }
            
            print("User created on Firebase: \(user.email ?? "Unknown email")")
        }
    }
}

