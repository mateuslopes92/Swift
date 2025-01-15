//
//  UserAuth.swift
//  Habit
//
//  Created by Mateus Lopes on 13/01/25.
//

import Foundation

struct UserAuth: Codable {
    var idToken: String
    var refreshToken: String
    var expires: Double = 0.0
    var TokenType: String
    
    enum CodingKeys: String, CodingKey {
        case idToken = "id_token"
        case refreshToken = "refresh_token"
        case expires
        case TokenType = "token_type"
    }
}
