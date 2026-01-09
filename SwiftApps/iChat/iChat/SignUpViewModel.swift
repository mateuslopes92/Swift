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

class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var image: UIImage = UIImage()
    
    @Published var formInvalid: Bool = false
    var alertText: String = ""
    
    @Published var isLoading: Bool = false
    
    func signUp(){
        if(image.size.width <= 0){
            self.formInvalid = true
            self.alertText = "Select a profile image"
            return
        }
        
        self.isLoading = true
        
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
            
            self.uploadPhoto()
        }
    }
    
    private func uploadPhoto(){
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata){ metadata, error in
            ref.downloadURL{ url, err in
                if(err != nil){
                    print("Error uploading photo \(err?.localizedDescription, default: "Error description not available")")
                }
                
                self.isLoading = false
                print("Photo created \(url, default: "Photo not uploaded")")
                
            }
        }
    }
}

