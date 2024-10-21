//
//  SignInViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 15/10/24.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var uiState: SignInUIState = .none
    
    func signIn(email: String, password: String) {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
           // self.uiState = .goToHomeScreen
            self.uiState = .goToHomeScreen
        }
    }
}

extension SignInViewModel {
    func homeView() -> some View {
        SignInViewRouter.makeHomeView()
    }
}

extension SignInViewModel {
    func signUpView() -> some View {
        SignInViewRouter.makeSignUpView()
    }
}


