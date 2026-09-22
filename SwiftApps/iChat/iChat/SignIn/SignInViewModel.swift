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
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var formInvalid: Bool = false
    var alertText: String = ""
    
    @Published var isLoading: Bool = false
    
    private let signInRepository: SignInRepository
    
    init(signInRepository: SignInRepository){
        self.signInRepository = signInRepository
    }
    
    func signIn(){
        isLoading = true
        
        signInRepository.signIn(withEmail: email, password: password) { err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
            }
            
            self.isLoading = false
        }
    }
}
