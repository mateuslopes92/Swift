//
//  HabitView.swift
//  Habit
//
//  Created by Mateus Lopes on 21/01/25.
//

import Foundation
import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false){
                        VStack{
                            
                            if !viewModel.isCharts {
                                topContainer
                                
                                addButton
                            }
                            
                          
                            if case HabitUIState.emptyList = viewModel.uiState {
                                Spacer(minLength: 60)
                                VStack{
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    
                                    Text("No habits found :(")
                                }
                            } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                                LazyVStack {
                                    
                                    ForEach(rows){ row in
                                        HabitCardView(viewModel: row, isCharts: viewModel.isCharts)
                                    }
                                    
                                }.padding(.bottom, 16)
                            } else if case HabitUIState.error(let msg) = viewModel.uiState {
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
                            }
                        }
                    }
                    .navigationTitle("My Habits")
                    .padding(.horizontal, 16)
                }
            }
        }.onAppear(){
            viewModel.onAppear()
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.6), Color.red.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 70, height: 70)
                    .shadow(color: .gray.opacity(0.4), radius: 6, x: 0, y: 4)
                
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }

            Text(viewModel.title)
                .font(.largeTitle).bold()
                .foregroundColor(.orange)
                .multilineTextAlignment(.center)

            Text(viewModel.subtitle)
                .font(.title3).bold()
                .foregroundColor(Color("textColor"))
                .multilineTextAlignment(.center)

            Text(viewModel.description)
                .font(.subheadline)
                .foregroundColor(Color("textColor"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 6)
        .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink(destination: Text("Add Habit Screen").frame(width: .infinity, height: .infinity)){
            Label("Add Habit", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }.padding(.top, 16)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            HomeViewRouter.makeHabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}


