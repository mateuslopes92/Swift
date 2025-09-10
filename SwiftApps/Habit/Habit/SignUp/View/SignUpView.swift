//
//  SignUpView.swift
//  Habit
//
//  Created by Mateus Lopes on 19/10/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center){
                    VStack(alignment: .center, spacing: 12) {
                        Text("Sign Up")
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 48)
                            .foregroundColor(Color("textColor"))
                        
                        fullNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        genderField
                        
                        saveButton
                    }
                     
                    Spacer()
                }
                
                if case SignUpUIState.error(let error) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                                // handle button
                            })
                        }
                }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Full Name *",
                     keyboardType: .alphabet,
                     error: "full name should have at least 4 characters",
                     failure: viewModel.fullName.count < 3,
                     isSecure: false,
                     autoCapitalization: .words
        )
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail *",
                     keyboardType: .emailAddress,
                     error: "e-mail is invalid",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Password *",
                     keyboardType: .emailAddress,
                     error: "password should have at least 8 characters",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "CPF *",
                     mask: "###.###.###-##",
                     keyboardType: .numberPad,
                     error: "CPF should have at least 11 characters",
                     failure: viewModel.document.count != 14,
                     isSecure: false)
        // TODO mask
        // TODO isDisabled
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Phone",
                     mask: "(##) ####-####",
                     keyboardType: .numberPad,
                     error: "phone should have ddd + 9 characters",
                     failure: viewModel.phone.count < 14 || viewModel.phone.count > 15,
                     isSecure: false)
        // TODO mask
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Birthday",
                     mask: "##/##/####",
                     keyboardType: .numberPad,
                     error: "your birthday should have dd/mm/yyyy",
                     failure: viewModel.birthday.count != 10,
                     isSecure: false)
        // TODO mask
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(
            text: "Sign Up",
            action: {
                viewModel.signUp()
            },
            disabled:
                !viewModel.email.isEmail() ||
                viewModel.password.count < 8 ||
                viewModel.fullName.count < 3 ||
                viewModel.birthday.count != 10 ||
                viewModel.document.count < 14 ||
                viewModel.phone.count < 14 || viewModel.phone.count > 15,
            showProgress: viewModel.uiState == SignUpUIState.loading
        )
        .padding(.top)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = SignUpViewModel(interactor: SignUpInteractor())
            SignUpView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
