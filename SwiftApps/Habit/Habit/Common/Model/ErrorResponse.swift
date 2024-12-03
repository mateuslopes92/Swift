//
//  ErrorResponse.swift
//  Habit
//
//  Created by Mateus Lopes on 02/12/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
