//
//  HabitDetailRemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 03/04/25.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    // singleton pattern
    // only one instance on the entire application
    
    static let shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId) // this replace %d with habitId
            
            WebService.call(path: path, method: .post, body: request){ result in
                switch result {
                    case .success(_):
                        promise(.success(true))
                        break
                    case .failure(_, let data):
                        if let data = data {
                            let jsonDecoder = JSONDecoder()
                            let response = try? jsonDecoder.decode(SignInErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Unknown error")))
                        }
                        break
                }
            }
        }
    }
}
