//
//  HabitView.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//

import Foundation
import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else if case HabitUIState.emptyList = viewModel.uiState {
                //
            } else if case HabitUIState.fullList = viewModel.uiState {
                //
            } else if case HabitUIState.error = viewModel.uiState {
                //
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

#Preview {
    HomeViewRouter.makeHabitView()
}


