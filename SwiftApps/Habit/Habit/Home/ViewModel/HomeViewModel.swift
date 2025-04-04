//
//  HomeViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 17/10/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let habitViewModel = HabitViewModel(interactor: HabitInteractor())
}


extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
}
