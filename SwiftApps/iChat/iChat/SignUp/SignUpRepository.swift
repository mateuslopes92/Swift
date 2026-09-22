//
//  SignUpRepository.swift
//  iChat
//
//  Created by Mateus Lopes on 21/09/26.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpRepository {
    func signUp(withEmail email: String, password: String, image: UIImage, name: String, completion: @escaping (String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) {
            result, err in
            
            guard let user = result?.user, err == nil else {
                completion(err?.localizedDescription ?? "Unknown Error")
                
                return
            }
            print("User created on Firebase: \(user.email ?? "Unknown email")")
            
            self.uploadPhoto(image: image, name: name){ err in
                if let err = err {
                    completion(err)
                }
            }
        }
    }
    
    private func uploadPhoto(image: UIImage, name: String, completion: @escaping (String?) -> Void){
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata){ result in
            ref.downloadURL{ url, error in
                guard let url = url else { return }
                print("foto criada \(url)")
                self.createUser(photoURL: url, name: name, completion: completion)
            }
        }
    }
    
    private func createUser(photoURL: URL, name: String, completion: @escaping (String?) -> Void){
        let id = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("users")
            .document(id)
            .setData([
                "name": name,
                "uuid": id,
                "profileUrl": photoURL.absoluteString
            ]) { err in
                if let err = err {
                    print(err.localizedDescription)
                    completion(err.localizedDescription)
                    return
                }
            }
    }
}
