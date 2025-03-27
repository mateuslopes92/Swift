//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Mateus Lopes on 26/03/25.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case sucess
    case error(String)
}
