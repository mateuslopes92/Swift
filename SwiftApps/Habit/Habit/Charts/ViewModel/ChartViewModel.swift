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
        "01/07/2025",
        "02/07/2025",
        "03/07/2025",
        "04/07/2025",
        "05/07/2025",
        "06/07/2025",
        "07/07/2025",
        "08/07/2025",
        "09/07/2025",
        "10/07/2025",
    ]
}
