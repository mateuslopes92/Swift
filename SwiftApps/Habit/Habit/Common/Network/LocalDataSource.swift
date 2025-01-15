//
//  LocalDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 13/01/25.
//

import Foundation
import Combine

class LocalDataSource {
    static let shared: LocalDataSource = LocalDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    private func setValue(value: UserAuth){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    private func getValue(forKey key: String) -> UserAuth? {
        var userAuth: UserAuth?
        
        if let data = UserDefaults.standard.value(forKey: "user_key") as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        
        return userAuth
    }
}

extension LocalDataSource {
    func insertUserAuth(userAuth: UserAuth){
        setValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = getValue(forKey: "user_key")
        return Future { promise in
            if let userAuth {
                promise(.success(userAuth))
            } else {
                print("Failed to retrieve userAuth: Value not found.")
                           promise(.success(nil))
            }
        }
    }
    
}
