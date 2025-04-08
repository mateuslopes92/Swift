//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 06/04/25.
//

import Foundation
import Combine

class HabitDetailInteractor {
    private let remote: HabitDetailRemoteDataSource = .shared
}

extension HabitDetailInteractor {
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return remote.save(habitId: habitId, request: request)
    }
}
