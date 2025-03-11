//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView() -> some View {
        let viewModel = HabitViewModel(interactor: HabitInteractor())
        return HabitView(viewModel: viewModel)
    }
}
