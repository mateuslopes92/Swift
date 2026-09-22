//
//  SignInRepository.swift
//  iChat
//
//  Created by Mateus Lopes on 21/09/26.
//

import Foundation
import FirebaseAuth

class SignInRepository {
    func signIn(withEmail email: String, password: String, completion: @escaping (String?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) {
            result, err in
            
            guard let user = result?.user, err == nil else {
                completion(err?.localizedDescription ?? "Unknown Error")
                
                return
            }
            
            print("User loged on Firebase: \(user.uid ?? "Unknown email")")
            completion(nil)
        }
    }
}
