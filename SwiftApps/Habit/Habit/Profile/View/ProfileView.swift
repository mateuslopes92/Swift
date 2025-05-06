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
    
    @State var email = "Testmateus@test.com"
    @State var cpf = "123.456.789-00"
    @State var phone = "(44) 98765-4321"
    @State var birthday = "27/03/1996"
    @State var selectedGender: Gender? = .male
    
    var disabledSave: Bool {
        viewModel.fullNameValidation.failure || viewModel.phoneValidation.failure || viewModel.birthdayValidation.failure
    }
    
    var body: some View {
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
                            TextField("", text: $email)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                                .disabled(true)
                        }
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                                .disabled(true)
                        }
                        
                        HStack {
                            Text("Phone Number")
                            Spacer()
                            TextField("Enter your phone number", text: $viewModel.phoneValidation.value)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        if viewModel.phoneValidation.failure {
                            Text("Enter with DDD + 8 or 9 digits")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        
                        
                        HStack {
                            Text("Birthday")
                            Spacer()
                            TextField("Enter your birthday", text: $viewModel.birthdayValidation.value)
                                .multilineTextAlignment(.trailing)
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
                                            selectedGender: $selectedGender,
                            ),
                            label: {
                                HStack {
                                    Text("Gender")
                                    Spacer()
                                    Text(selectedGender?.rawValue ?? "")
                                }
                            }
                        )
                    }
                }
                
            }
            .navigationBarTitle(Text("Edit Profile"), displayMode: .automatic)
            .navigationBarItems(trailing:
                Button(
                    action: {},
                    label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.orange)
                    }
                ).opacity(disabledSave ? 0 : 1)
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            ProfileView(viewModel: ProfileViewModel())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}

