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
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = nil
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?

    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {
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
        cancellable = interactor.save(habitCreateRequest: HabitCreateRequest(imageData: imageData, name: name, label: label))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                }
            }, receiveValue: {
                self.uiState = .success
                self.habitPublisher?.send(true)
            })
    }
}
