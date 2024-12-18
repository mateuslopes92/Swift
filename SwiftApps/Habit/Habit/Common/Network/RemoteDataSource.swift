//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 09/12/24.
//
import Foundation
import Combine

class RemoteDataSource {
    // singleton pattern
    // only one instance on the entire application
    
    static let shared = RemoteDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func signIn(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promise in
            WebService.call(path: .signIn, params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
            ]){ result in
                switch result {
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                        let response = try? jsonDecoder.decode(SignInResponse.self, from: data)
                    
                        guard let response = response else {
                            print("Log: Error parser \(String(data: data, encoding: .utf8))")
                            return
                        }
                    
                        promise(.success(response))
                        break
                    case .failure(let error, let data):
                        if let data = data {
                            if error == .unauthorized {
                                let jsonDecoder = JSONDecoder()
                                let response = try? jsonDecoder.decode(SignInErrorResponse.self, from: data)
                                promise(.failure(AppError.response(message: response?.detail.message ?? "Unknown error")))
                            }
                        }
                        break
                }
            }
        }
    }
}
