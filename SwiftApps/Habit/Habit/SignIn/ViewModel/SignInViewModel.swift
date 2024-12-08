//
//  SignInViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 15/10/24.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
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
    
    func signIn() {
        self.uiState = .loading
        
        WebService.signIn(request: SignInRequest(email: email, password: password)) {(successResponse, errorResponse) in
            
            // non main thread
            if let error = errorResponse {
                // Main thread
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail.message)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    print(success)
                    self.uiState = .goToHomeScreen
//                    self.publisher.send(success)
                }
            }
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


