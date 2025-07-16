//
//  ChartViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 08/07/25.
//
import Foundation
import SwiftUI
import Charts

class ChartViewModel: ObservableObject {
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 5.0),
        ChartDataEntry(x: 3.0, y: 6.0),
        ChartDataEntry(x: 4.0, y: 1.0),
        ChartDataEntry(x: 5.0, y: 4.0),
        ChartDataEntry(x: 6.0, y: 4.0),
        ChartDataEntry(x: 7.0, y: 5.0),
        ChartDataEntry(x: 8.0, y: 9.0),
        ChartDataEntry(x: 9.0, y: 8.0),
        ChartDataEntry(x: 10.0, y: 7.0),
    ]
    @Published var dates = [
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
        "2025-01-07",
    ]
}
