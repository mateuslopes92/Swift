//
//  HabitViewRouter.swift
//  Habit
//
//  Created by Mateus Lopes on 05/08/25.
//
import Foundation
import Combine
import SwiftUI

enum HabitViewRouter {
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
}
