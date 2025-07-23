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
        ZStack {
            if case ChartUIState.loading = viewModel.uiState{
                ProgressView()
            } else {
                if case ChartUIState.emptyChart = viewModel.uiState {
                    VStack {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("No habits found :(")
                    }
                } else if case ChartUIState.error(let msg) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)){
                            Alert(
                                title: Text("Ops! \(msg)"),
                                message: Text("Try again?"),
                                primaryButton: .default(Text("Yes")){
                                    viewModel.onAppear()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                } else {
                    BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                        .frame(maxWidth: .infinity, maxHeight: 350)
                }
               
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}



struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            HabitCardViewRouter.makeChartView(id: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
