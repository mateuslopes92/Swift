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
    
    @Published var image: UIImage = UIImage()
    
    @Published var formInvalid: Bool = false
    var alertText: String = ""
    
    @Published var isLoading: Bool = false
    
    func signUp(){
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) {
            result, err in
            
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err?.localizedDescription ?? "Unknown Error"
                
                self.isLoading = false
                return
            }
            
            self.isLoading = false
            print("User created on Firebase: \(user.email ?? "Unknown email")")
        }
    }
}

