//
//  SignInViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 01/11/25.
//
import Foundation
import Combine
import FirebaseAuth

class SignInViewModel: ObservableObject {
    var email: String = ""
    var password: String = ""

    @Published var formInvalid: Bool = false
    var alertText: String = ""
    
    @Published var isLoading: Bool = false
    
    func signIn(){
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) {
            result, err in
            
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err?.localizedDescription ?? "Unknown Error"
                
                self.isLoading = false
                return
            }
            
            self.isLoading = false
            print("User loged on Firebase: \(user.uid ?? "Unknown email")")
        }
    }
}
