//
//  SignUpViewModel.swift
//  iChat
//
//  Created by Mateus Lopes on 03/11/25.
//
import Foundation
import Combine
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var image: UIImage = UIImage()
    
    @Published var formInvalid: Bool = false
    var alertText: String = ""
    
    @Published var isLoading: Bool = false
    
    private let signUpRepository: SignUpRepository
    
    init(signUpRepository: SignUpRepository){
        self.signUpRepository = signUpRepository
    }
    
    func signUp(){
        if(image.size.width <= 0){
            self.formInvalid = true
            self.alertText = "Select a profile image"
            return
        }
        
        self.isLoading = true
        
        signUpRepository.signUp(withEmail: email, password: password, image: image, name: name){ err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
            }
            self.isLoading = false
        }
    }
}

