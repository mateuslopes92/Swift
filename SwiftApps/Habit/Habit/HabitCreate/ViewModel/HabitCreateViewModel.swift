//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 01/08/25.
//

import Foundation
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    @Published var uiState: HabitDetailUIState = .none
    @Published var name = ""
    @Published var label = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?

    let interactor: HabitDetailInteractor
    
    init(interactor: HabitDetailInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func save() {
        uiState = .loading
    }
}
