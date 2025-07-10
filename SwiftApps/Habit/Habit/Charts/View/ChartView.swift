//
//  ChartView.swift
//  Habit
//
//  Created by Mateus Lopes on 25/06/25.
//

import Foundation
import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
            .frame(maxWidth: .infinity, maxHeight: 350)
    }
}



struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            ChartView(viewModel: ChartViewModel())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
