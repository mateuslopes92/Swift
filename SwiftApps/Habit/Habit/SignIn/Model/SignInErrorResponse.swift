//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Mateus Lopes on 08/12/24.
//

import Foundation

struct SignInDetailErrorResponse: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct SignInErrorResponse: Decodable {
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
