//
//  ChartViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 08/07/25.
//
import Foundation
import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject {
    @Published var uiState = ChartUIState.loading
    @Published var entries: [ChartDataEntry] = []
    @Published var dates: [String] = []
    
    private var cancellable: AnyCancellable?
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear() {
        cancellable = interactor.fetchHabitValues(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                case .finished:
                    break
                }
            }, receiveValue: { response in
                
                print(response)
            })
    }
    
}
