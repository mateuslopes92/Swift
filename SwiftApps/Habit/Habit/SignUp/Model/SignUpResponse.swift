//
//  SignUpResponse.swift
//  Habit
//
//  Created by Mateus Lopes on 02/12/24.
//

import Foundation

struct SignUpResponse: Decodable {
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
