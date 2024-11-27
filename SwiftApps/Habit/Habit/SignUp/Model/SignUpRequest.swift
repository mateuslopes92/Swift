//
//  SignUpRequest.swift
//  Habit
//
//  Created by Mateus Lopes on 24/11/24.
//

import Foundation

struct SignUpRequest: Encodable {
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let gender: Int
    let birthday: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case document
        case phone
        case gender
        case birthday
        case password
    }
}
