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
    
    private var cancelableRequest: AnyCancellable?
    
    private let interactor: SignInInteractor
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        
        cancellable = publisher.sink { value in
            print("User created", value)
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancelableRequest?.cancel()
    }
    
    func signIn() {
        self.uiState = .loading
        
        cancelableRequest = interactor.signIn(request: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion){
                    case .failure(let appError):
                        self.uiState = SignInUIState.error(appError.message)
                        break
                    case .finished:
                        break
                }
            } receiveValue: { success in
                print(success)
                self.uiState = .goToHomeScreen
            }

        
//        interactor.signIn(request: SignInRequest(email: email, password: password)) {(successResponse, errorResponse) in
//            
//            // non main thread
//            if let error = errorResponse {
//                // Main thread
//                DispatchQueue.main.async {
//                    
//                }
//            }
//            
//            if let success = successResponse {
//                DispatchQueue.main.async {
//                    
////                    self.publisher.send(success)
//                }
//            }
//        }
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


