//
//  SignInUIState.swift
//  Habit
//
//  Created by Mateus Lopes on 16/10/24.
//

import Foundation

enum SignInUIState {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
