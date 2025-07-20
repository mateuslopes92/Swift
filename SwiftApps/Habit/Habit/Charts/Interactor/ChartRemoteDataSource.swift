//
//  ChartRemoteDataSource.swift
//  Habit
//
//  Created by Mateus Lopes on 19/07/25.
//

import Foundation
import Combine

class ChartRemoteDataSource {
    static let shared: ChartRemoteDataSource = ChartRemoteDataSource()
    
    // private constructor to avoid other classes to instance this class
    private init(){
        
    }
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError>{
        return Future { promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .get){ result in
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
                        let response = try? decoder.decode([HabitValueResponse].self, from: data)
                         
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
