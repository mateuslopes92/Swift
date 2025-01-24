//
//  HabitViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title = "Attention!"
    @Published var subtitle = "Stay tuned!"
    @Published var description = "You`re lazy on habits"
}
