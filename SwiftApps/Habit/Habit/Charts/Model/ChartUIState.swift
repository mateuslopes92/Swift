//
//  CharUIState.swift
//  Habit
//
//  Created by Mateus Lopes on 22/07/25.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
