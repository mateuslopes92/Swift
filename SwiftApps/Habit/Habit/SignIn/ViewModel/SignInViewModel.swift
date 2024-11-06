//
//  SignInViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 15/10/24.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Published var uiState: SignInUIState = .none
    private let publisher = PassthroughSubject<Bool, Never>()
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = publisher.sink { value in
            print("User created", value)
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func signIn(email: String, password: String) {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.uiState = .goToHomeScreen
//            self.uiState = .error("error")
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
        SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}


