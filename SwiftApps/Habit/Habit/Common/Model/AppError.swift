//
//  AppError.swift
//  Habit
//
//  Created by Mateus Lopes on 17/12/24.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
            case .response(message: let message):
                return message
        }
    }
}
