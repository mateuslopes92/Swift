//
//  HabitCreateDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 19/08/25.
//
import Foundation
import Combine

class HabitCreateDataSource {
    // singleton pattern
    // only one instance on the entire application
    
    static let shared: HabitCreateDataSource = HabitCreateDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func save(request: HabitCreateRequest) -> Future<Void, AppError> {
        return Future<Void, AppError> { promise in
            WebService.call(path: .habits, params: [
                URLQueryItem(name: "name", value: request.name),
                URLQueryItem(name: "label", value: request.label)
            ], data: request.imageData){ result in
                switch result {
                    case .success(_):
                        promise(.success( () ))
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
