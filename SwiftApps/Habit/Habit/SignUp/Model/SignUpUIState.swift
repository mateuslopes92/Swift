//
//  SignUpUiState.swift
//  Habit
//
//  Created by Mateus Lopes on 27/10/24.
//

import Foundation


enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
