//
//  SignUpView.swift
//  iChat
//
//  Created by Mateus Lopes on 03/11/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: SignUpViewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            Image("chat_logo")
                .resizable()
                .scaledToFit()
                .padding()
            
            TextField("Name", text: $viewModel.name)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(
                            Color(UIColor.separator),
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.bottom, 10)
            
            TextField("E-mail", text: $viewModel.email)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(
                            Color(UIColor.separator),
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.bottom, 10)
                
            
            SecureField("Password", text: $viewModel.password)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(
                            Color(UIColor.separator),
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.bottom, 30)
            
            Button{
                viewModel.signUp()
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("GreenColor"))
                    .foregroundColor(Color.white)
                    .cornerRadius(24.0)
                    
            }
            
            Divider()
                .padding()
            
            Button{
                print("Clicked")
            } label: {
                Text("Dont have an account? Click here")
                    .foregroundColor(Color.black)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 32)
        .background(Color.init(red: 240 / 255, green: 231 / 255, blue: 210 / 255))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SignUpView()
}
