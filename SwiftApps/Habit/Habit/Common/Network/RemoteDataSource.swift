//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 09/12/24.
//
import Foundation

class RemoteDataSource {
    // singleton pattern
    // only one instance on the entire application
    
    static let shared = RemoteDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func signIn(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void){
        WebService.call(path: .signIn, params: [
            URLQueryItem(name: "username", value: request.email),
            URLQueryItem(name: "password", value: request.password)
        ]){ result in
            switch result {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    let response = try? jsonDecoder.decode(SignInResponse.self, from: data)
                    completion(response, nil)
                    break
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let jsonDecoder = JSONDecoder()
                            let response = try? jsonDecoder.decode(SignInErrorResponse.self, from: data)
                            completion(nil, response)
                        }
                    }
                    break
            }
        }
    }
}
