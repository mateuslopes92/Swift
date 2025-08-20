//
//  HabitCreateInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 19/08/25.
//
import Foundation
import Combine

// in kotlin for instance a interactor is called repository
class HabitCreateInteractor {
    private let remote: HabitCreateDataSource = .shared
}

extension HabitCreateInteractor {
    func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppError> {
        return remote.save(request: request)
    }
}
