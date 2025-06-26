//
//  ChartView.swift
//  Habit
//
//  Created by Mateus Lopes on 25/06/25.
//

import Foundation
import SwiftUI

struct ChartView: View {
    var body: some View {
        Text("ChartView")
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            ChartView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
