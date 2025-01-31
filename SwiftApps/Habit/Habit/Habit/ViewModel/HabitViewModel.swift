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
    
    func onAppear() {
        self.uiState = .emptyList
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var rows: [HabitCardViewModel] = []
            
            rows.append(HabitCardViewModel(
                id: 1,
                icon: "https://placehold.co/600x400/000000/FFF",
                date: "01/01/2025",
                name: "Play guitar",
                label: "hours",
                value: "2",
                state: .green
            ))
            
            rows.append(HabitCardViewModel(
                id: 2,
                icon: "https://placehold.co/600x400/000000/FFF",
                date: "01/01/2025",
                name: "Walk",
                label: "km",
                value: "2",
                state: .green
            ))
            
            rows.append(HabitCardViewModel(
                id: 3,
                icon: "https://placehold.co/600x400/000000/FFF",
                date: "01/01/2025",
                name: "Walk",
                label: "km",
                value: "2",
                state: .green
            ))
            
            rows.append(HabitCardViewModel(
                id: 4,
                icon: "https://placehold.co/600x400/000000/FFF",
                date: "01/01/2025",
                name: "Walk",
                label: "km",
                value: "2",
                state: .green
            ))
            
//            self.uiState = .fullList(rows)
            self.uiState = .error("error")
        }
    }
}
