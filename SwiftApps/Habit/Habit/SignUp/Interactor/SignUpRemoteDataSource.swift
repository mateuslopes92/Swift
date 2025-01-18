//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 06/01/25.
//

//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 09/12/24.
//
import Foundation
import Combine

class SignUpRemoteDataSource {
    // singleton pattern
    // only one instance on the entire application
    
    static let shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError>{
        return Future<Bool, AppError> { promise in
            WebService.call(path: .postUser, method: .post, body: request){ result in
                switch result {
                    case .success(_):
                        promise(.success(true))
                        break
                    case .failure(let error, let data):
                        if let data = data {
                            if error == .badRequest {
                                let jsonDecoder = JSONDecoder()
                                let response = try? jsonDecoder.decode(ErrorResponse.self, from: data)
                                promise(.failure(AppError.response(message: response?.detail ?? "Internal server error")))
                            }
                        }
                        break
                }
            }
        }

    }
}
