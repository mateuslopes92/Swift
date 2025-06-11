//
//  ProfileResponse.swift
//  Habit
//
//  Created by Mateus Lopes on 09/06/25.
//

import Foundation

struct ProfileResponse: Decodable {
    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let gender: Int
    let birthday: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "name"
        case email
        case document
        case phone
        case gender
        case birthday
    }
}
