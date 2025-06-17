//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 09/06/25.
//
import Foundation
import Combine

class ProfileRemoteDataSource {
    // singleton pattern
    // only one instance on the entire application
    
    static let shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func fetchUser() -> Future<ProfileResponse, AppError>{
        return Future { promise in
            WebService.call(path: .fetchUser, method: .get){ result in
                switch result {
                    case .failure(_, let data):
                        if let data = data {
                            let jsonDecoder = JSONDecoder()
                            let response = try? jsonDecoder.decode(ErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail ?? "Internal server error")))
                        }
                        break
                    case .success(let data):
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ProfileResponse.self, from: data)
                         
                        guard let res = response else {
                            print("Log: error parser \(String(data: data, encoding: .utf8))")
                            return
                        }
                    
                        promise(.success(res))
                        break
                }
            }
        }
    }
    
    func updateUser(userId: Int, request profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError>{
        return Future { promise in
            let path = String(format: WebService.Endpoint.updateUser.rawValue, userId)
            WebService.call(path: path, method: .put, body: profileRequest){ result in
                switch result {
                    case .failure(_, let data):
                        if let data = data {
                            let jsonDecoder = JSONDecoder()
                            let response = try? jsonDecoder.decode(ErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail ?? "Internal server error")))
                        }
                        break
                    case .success(let data):
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ProfileResponse.self, from: data)
                         
                        guard let res = response else {
                            print("Log: error parser \(String(data: data, encoding: .utf8))")
                            return
                        }
                    
                        promise(.success(res))
                        break
                }
            }
        }
    }
}
