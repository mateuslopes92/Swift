//
//  ProfileRequest.swift
//  Habit
//
//  Created by Mateus Lopes on 16/06/25.
//

import Foundation

struct ProfileRequest: Encodable {
    let fullName: String
    let phone: String
    let gender: Int
    let birthday: String

    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case phone
        case gender
        case birthday
    }
}
