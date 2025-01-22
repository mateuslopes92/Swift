//
//  HabitViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var uiState: HabitUIState = .loading
}
