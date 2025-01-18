//
//  RefreshRequest.swift
//  Habit
//
//  Created by Mateus Lopes on 18/01/25.
//

import Foundation

struct RefreshRequest: Encodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
