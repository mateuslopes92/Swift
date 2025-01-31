//
//  HabitUiState.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
