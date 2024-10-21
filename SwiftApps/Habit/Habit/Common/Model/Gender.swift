//
//  Gender.swift
//  Habit
//
//  Created by Mateus Lopes on 19/10/24.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"
    
    var id: String {
        self.rawValue
    }
}
