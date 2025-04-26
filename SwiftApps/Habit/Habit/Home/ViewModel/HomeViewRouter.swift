//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
    static func makeProfileView(viewModel: HabitViewModel) -> some View {
        return ProfileView()
    }
}
