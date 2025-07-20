//
//  ChartInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 19/07/25.
//

import Foundation
import Combine

class ChartInteractor {
    private let remoteProfile: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError>{
        return remoteProfile.fetchHabitValues(habitId: habitId)
    }
}

