//
//  HabitViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//
import Foundation
import Combine
import SwiftUICore

class HabitViewModel: ObservableObject {
    @Published var uiState: HabitUIState = .loading
    
    @Published var title = ""
    @Published var subtitle = ""
    @Published var description = ""
    
    private let interactor: HabitInteractor
    private var cancelableRequest: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    let isCharts: Bool
    
    init(isCharts: Bool, interactor: HabitInteractor) {
        self.isCharts = isCharts
        self.interactor = interactor
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
            print("saved \(saved)")
            self.onAppear()
        })
    }
    
    deinit {
        cancelableRequest?.cancel()
    }
    
    func onAppear() {
        self.uiState = .loading
        
        cancelableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                    case .failure(let appError):
                    self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                }
            }, receiveValue: { response in
                print("Call of tasks")
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = "No habits yet!"
                    self.subtitle = "Add your first habit!"
                    self.description = ""
                } else {
                    self.uiState = .fullList(
                        response.map {
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Thats good!"
                            self.subtitle = "Your habits are on track"
                            self.description = ""
                            
                            let lastDateCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            
                            if lastDateCompare < Date() {
                                state = Color.red
                                self.title = "Attention!"
                                self.subtitle = "Be more active!"
                                self.description = "Your habits are not on track"
                            }
                            
                            return HabitCardViewModel(
                                id: $0.id,
                                icon: $0.iconUrl ?? "",
                                date: String(lastDate),
                                name: $0.name,
                                label: $0.label,
                                value: String($0.value ?? 0),
                                state: state,
                                habitPublisher: self.habitPublisher
                            )
                        }
                    )
                }
            })
        }
}
