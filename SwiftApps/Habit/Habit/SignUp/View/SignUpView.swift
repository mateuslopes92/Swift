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
    // todo: gender
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center){
                    VStack(alignment: .center, spacing: 20) {
                        Text("Sign Up")
                            .font(Font.system(.title).bold())
                            .padding(48)
                            .foregroundColor(.orange)
                        
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
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        TextField("Full Name", text: $fullName)
            .padding(.horizontal)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

extension SignUpView {
    var emailField: some View {
        TextField("Email", text: $email)
            .padding(.horizontal)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

extension SignUpView {
    var passwordField: some View {
        SecureField("Password", text: $password)
            .padding(.horizontal)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

extension SignUpView {
    var documentField: some View {
        SecureField("Document", text: $document)
            .padding(.horizontal)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

extension SignUpView {
    var phoneField: some View {
        SecureField("Phone", text: $phone)
            .padding(.horizontal)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

extension SignUpView {
    var birthdayField: some View {
        SecureField("Birth Day", text: $birthday)
            .padding(.horizontal)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
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
        .padding(.horizontal)
    }
}

extension SignUpView {
    var saveButton: some View {
        Button("Sign Up") {
            //
        }
        .padding(.top)
    }
}

#Preview {
    SignUpView()
}
