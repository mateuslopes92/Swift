//
//  SignUpView.swift
//  Habit
//
//  Created by Mateus Lopes on 19/10/24.
//

import SwiftUI

struct SignUpView: View {

    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender = Gender.male
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center){
                    VStack(alignment: .center, spacing: 12) {
                        Text("Sign Up")
                            .font(Font.system(.title).bold())
                            .padding(48)
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
        EditTextView(text: $fullName,
                     placeholder: "Full Name",
                     keyboardType: .default,
                     error: "full name should have at least 4 characters",
                     failure: fullName.count < 4,
                     isSecure: false)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $email,
                     placeholder: "E-mail",
                     keyboardType: .emailAddress,
                     error: "e-mail is invalid",
                     failure: !email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $password,
                     placeholder: "Password",
                     keyboardType: .emailAddress,
                     error: "password should have at least 8 characters",
                     failure: password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $document,
                     placeholder: "Document",
                     keyboardType: .numberPad,
                     error: "document should have at least 11 characters",
                     failure: document.count < 11,
                     isSecure: false)
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $phone,
                     placeholder: "Phone",
                     keyboardType: .numberPad,
                     error: "phone should have at least 8 characters",
                     failure: phone.count < 8,
                     isSecure: false)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $birthday,
                     placeholder: "Birthday",
                     keyboardType: .numberPad,
                     error: "phone should have at least 8 characters",
                     failure: birthday.count < 8,
                     isSecure: false)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

extension SignUpView {
    var saveButton: some View {
        Button("Sign Up") {
            viewModel.signUp()
        }
        .padding(.top)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = SignUpViewModel()
            SignUpView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
