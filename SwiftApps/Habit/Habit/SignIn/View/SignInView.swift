//
//  SignInView.swift
//  Habit
//
//  Created by Mateus Lopes on 15/10/24.
//
import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    @State var email = ""
    @State var password = ""
    @State var action: Int? = 0
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 36) {
                    
                    Spacer(minLength: 36)
                    
                    VStack(alignment: .center, spacing: 8) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 48)
                        
                        Text("Sign in to your account")
                            .font(.headline.bold())
                            .padding(.horizontal, 48)
                            .foregroundColor(.orange)
                        
                        emailField
                        
                        passwordField

                        enterButton
                        
                        registerLink
                    }
                }
            }
            .navigationBarTitle("Sign in", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

extension SignInView {
    var emailField: some View {
        TextField("Email", text: $email)
            .padding()
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("Password", text: $password)
            .padding(.horizontal)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

extension SignInView {
    var enterButton: some View {
        Button("Sign in") {
            // func that handle click
        }
        .padding(.top)
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Don't have an account? Register here")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top)
                .onTapGesture {
                    // handle register
                }
            ZStack {
                NavigationLink(
                    destination: Text("Register"),
                    tag: 1,
                    selection: $action,
                    label: { EmptyView() }
                )
                
                Button("Register now"){
                    self.action = 1
                }
                .foregroundColor(.orange)
             
            }
        }
    }
}


#Preview {
    let viewModel = SignInViewModel()
    SignInView(viewModel: viewModel)
}

