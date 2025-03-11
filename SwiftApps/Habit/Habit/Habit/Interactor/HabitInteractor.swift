//
//  HabitInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 10/03/25.
//

import Foundation
import Combine

// in kotlin for instance a interactor is called repository
class HabitInteractor {
    private let remote: HabitRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension HabitInteractor {
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return remote.fetchHabits()
    }
}
