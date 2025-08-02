//
//  HabitCreateView.swift
//  Habit
//
//  Created by Mateus Lopes on 01/08/25.
//
import SwiftUI

struct HabitCreateView: View {
    @ObservedObject var viewModel: HabitCreateViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 12) {
                    Button(action: {
                        
                    }, label: {
                        VStack {
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color.orange)
                                Text("Click here to add a photo")
                                    .foregroundColor(Color.orange)
                            }
                        }
                    ).padding(.bottom, 16)
                 
                }
                
                Spacer().frame(height: 24)
                
                VStack {
                    TextField("Enter here the name of the habit", text: $viewModel.name)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 16)
                
                VStack {
                    TextField("Enter here the unit of the habit", text: $viewModel.label)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                }
                .padding(.horizontal, 32)
                
            }
            
            Spacer() // Pushes buttons to the bottom
            
            VStack {
                LoadingButtonView(
                    text: "Save",
                    action: {
                        viewModel.save()
                    },
                    disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty,
                    showProgress: self.viewModel.uiState == .loading
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                Button("Cancel") {
                    // dismiss pop exit
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.easeOut(duration: 0.15)){
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .modifier(ButtonStyle())
                .padding(.horizontal, 16)
            }
            .padding(.bottom) // Keeps buttons within safe area
        }.onAppear{
            viewModel.$uiState.sink { uiState in
                if uiState == .sucess {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.store(in: &viewModel.cancellables)
        }
    }
}
struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = HabitCreateViewModel(
                interactor: HabitDetailInteractor()
            )
            HabitCreateView(viewModel: viewModel)
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
