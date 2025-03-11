//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 10/03/25.
//
import Foundation
import Combine

class HabitRemoteDataSource {
    // singleton pattern
    // only one instance on the entire application
    
    static let shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return Future<[HabitResponse], AppError> { promise in
            WebService.call(path: .habits, method: .get){ result in
                switch result {
                    case .success(let data):
                        let jsonDecoder = JSONDecoder()
                    let response = try? jsonDecoder.decode([HabitResponse].self, from: data)
                    
                        guard let response = response else {
                            print("Log: Error parser \(String(data: data, encoding: .utf8))")
                            return
                        }
                    
                        promise(.success(response))
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

