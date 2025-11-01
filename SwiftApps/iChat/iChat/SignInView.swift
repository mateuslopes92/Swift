//
//  ContentView.swift
//  iChat
//
//  Created by Mateus Lopes on 01/11/25.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel: SignInViewModel = SignInViewModel()

    var body: some View {
        VStack {
            Image("chat_logo")
                .resizable()
                .scaledToFit()
                .padding()
            
            TextField("E-mail", text: $viewModel.email)
                .padding()
                .border(Color(UIColor.separator))
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .border(Color(UIColor.separator))
            
            Button{
                viewModel.signIn()
            } label: {
                Text("Login")
            }
            
            Divider()
            
            Button{
                print("Clicked")
            } label: {
                Text("Dont have an account? Click here")
            }
            
        }
    }
}

#Preview {
    SignInView()
}
