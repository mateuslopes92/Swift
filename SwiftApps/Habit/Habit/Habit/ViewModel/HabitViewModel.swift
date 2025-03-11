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
    
    init(interactor: HabitInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancelableRequest?.cancel()
    }
    
    func onAppear() {
//        self.uiState = .emptyList
        
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
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = "No habits yet!"
                    self.subtitle = "Add your first habit!"
                    self.description = ""
                } else {
                    self.uiState = .fullList(
                        response.map {
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            let lastDateCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Thats good!"
                            self.subtitle = "Your habits are on track"
                            self.description = ""
                            
                            if lastDate < Date().toString(destPattern: "dd/MM/yyyy HH:mm") {
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
                                value: String($0.value),
                                state: state
                            )
                        }
                    )
                }
            })
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            var rows: [HabitCardViewModel] = []
//            
//            rows.append(HabitCardViewModel(
//                id: 1,
//                icon: "https://placehold.co/600x400/000000/FFF",
//                date: "01/01/2025",
//                name: "Play guitar",
//                label: "hours",
//                value: "2",
//                state: .green
//            ))
//            
//            rows.append(HabitCardViewModel(
//                id: 2,
//                icon: "https://placehold.co/600x400/000000/FFF",
//                date: "01/01/2025",
//                name: "Walk",
//                label: "km",
//                value: "2",
//                state: .green
//            ))
//            
//            rows.append(HabitCardViewModel(
//                id: 3,
//                icon: "https://placehold.co/600x400/000000/FFF",
//                date: "01/01/2025",
//                name: "Walk",
//                label: "km",
//                value: "2",
//                state: .green
//            ))
//            
//            rows.append(HabitCardViewModel(
//                id: 4,
//                icon: "https://placehold.co/600x400/000000/FFF",
//                date: "01/01/2025",
//                name: "Walk",
//                label: "km",
//                value: "2",
//                state: .green
//            ))
//            
////            self.uiState = .fullList(rows)
//            self.uiState = .error("error")
        }
}
