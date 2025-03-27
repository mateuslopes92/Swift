//
//  HabitDetailView.swift
//  Habit
//
//  Created by Mateus Lopes on 26/03/25.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var viewModel: HabitDetailViewModel
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 12) {
                    Text(viewModel.name)
                        .font(.title.bold())
                        .foregroundColor(Color.orange)
                    
                    Text("Unit: \(viewModel.label)")
                }
                
                Spacer().frame(height: 24)
                
                VStack {
                    TextField("Enter here the value you got", text: $viewModel.value)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                }
                .padding(.horizontal, 32)
                
                Text("You should fill this in 24 hours\nHabits are built every day :)")
                    .padding(.top, 32)
                    .multilineTextAlignment(.center)
            }
            
            Spacer() // Pushes buttons to the bottom
            
            VStack {
                LoadingButtonView(
                    text: "Save",
                    action: {},
                    disabled: self.viewModel.value.isEmpty,
                    showProgress: self.viewModel.uiState == .loading
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                Button("Cancel") {
                    // dismiss pop exit
                }
                .modifier(ButtonStyle())
                .padding(.horizontal, 16)
            }
            .padding(.bottom) // Keeps buttons within safe area
        }
    }
}
struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = HabitDetailViewModel(
                id: 1, name: "Study", label: "hours"
            )
            HabitDetailView(viewModel: viewModel)
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
