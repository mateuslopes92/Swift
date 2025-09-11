//
//  ProfileView.swift
//  Habit
//
//  Created by Mateus Lopes on 26/04/25.
//
import Foundation
import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disabledSave: Bool {
        viewModel.fullNameValidation.failure || viewModel.phoneValidation.failure || viewModel.birthdayValidation.failure
    }
    
    var body: some View {
        ZStack {
            
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                NavigationView {
                    VStack {
                        
                        Form {
                            Section(header: Text("Register Data")) {
                                HStack {
                                    Text("Name")
                                    Spacer()
                                    TextField("Enter your name", text: $viewModel.fullNameValidation.value)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.alphabet)
                                }
                                if viewModel.fullNameValidation.failure {
                                    Text("Name should have more than 3 characters")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                
                                HStack {
                                    Text("Email")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundStyle(.gray)
                                        .disabled(true)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundStyle(.gray)
                                        .disabled(true)
                                }
                                
                                HStack {
                                    Text("Phone Number")
                                    Spacer()
                                    ProfileEditTextView(
                                         text: $viewModel.phoneValidation.value,
                                         placeholder: "Enter your Phone",
                                         mask: "(##) ####-####",
                                         keyboardType: .numberPad,
                                     )
                                }
                                if viewModel.phoneValidation.failure {
                                    Text("Enter with DDD + 8 or 9 digits")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                
                                HStack {
                                    Text("Birthday")
                                    Spacer()
                                    ProfileEditTextView(
                                         text: $viewModel.birthdayValidation.value,
                                         placeholder: "Enter your Birthday",
                                         mask: "##/##/####",
                                         keyboardType: .numberPad,
                                     )
                                }
                                if viewModel.birthdayValidation.failure {
                                    Text("Birthday should be in the format DD/MM/YYYY")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(
                                        title: "Gender",
                                        genders: Gender.allCases,
                                        selectedGender: $viewModel.gender,
                                    ),
                                    label: {
                                        HStack {
                                            Text("Gender")
                                            Spacer()
                                            Text(viewModel.gender?.rawValue ?? "")
                                        }
                                    }
                                )
                            }
                        }
                    }
                    .navigationBarTitle(Text("Edit Profile"), displayMode: .automatic)
                    .navigationBarItems(trailing:
                                            Button(
                                                action: {
                                                    viewModel.updateUser()
                                                },
                                                label: {
                                                    if case ProfileUIState.updateLoading = viewModel.uiState {
                                                        ProgressView()
                                                    } else {
                                                        Image(systemName: "checkmark")
                                                            .foregroundColor(.orange)
                                                    }
                                                }
                                            ).opacity(disabledSave ? 0 : 1)
                                            .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)){
                                                Alert(title: Text("Habit"), message: Text("User updated!"), dismissButton: .default(Text("Ok")) {
                                                    viewModel.uiState = .none
                                                })
                                            }
                                                
                    )
                }
            }
            
            if case ProfileUIState.fetchError(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            viewModel.uiState = .none
                        })
                    }
            }
            
            if case ProfileUIState.updateError(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            viewModel.uiState = .none
                        })
                    }
            }
            
        }.onAppear(perform: viewModel.fetchUser)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}

