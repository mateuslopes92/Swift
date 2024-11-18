//
//  SignInView.swift
//  Habit
//
//  Created by Mateus Lopes on 15/10/24.
//
import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action: Int? = 0
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationStack {
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
                                    .padding(.bottom, 16)
                                    .foregroundColor(.orange)
                                
                                emailField
                                
                                passwordField

                                enterButton
                                
                                Spacer()
                                
                                registerLink
                                
                                Text("Copyright © Mateus Consultoria e Desenvolvimento de Software LTDA 2022. \n All rights reserved.")
                                    .foregroundStyle(Color.gray)
                                    .font(Font.system(size: 12).bold())
                                    .padding(.top, 16)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        
                        if case SignInUIState.error(let error) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                                        // handle button
                                    })
                                }
                        }
                        
                    }
                    .navigationBarTitle("Sign in", displayMode: .inline)
                    .navigationBarHidden(true)
                }.padding(.horizontal)
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     keyboardType: .emailAddress,
                     error: "e-mail is invalid",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Password",
                     keyboardType: .emailAddress,
                     error: "password should have at least 8 characters",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(
            text: "Sign In",
            action: {
                viewModel.signIn()
            },
            disabled: !viewModel.email.isEmail() || viewModel.password.count < 8,
            showProgress: viewModel.uiState == SignInUIState.loading
        )
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
                NavigationLink {
                    viewModel.signUpView()
                }
                label: {
                    Text("Register Now")
                }.foregroundColor(.orange)
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = SignInViewModel()
            SignInView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}

