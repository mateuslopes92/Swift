//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 27/10/24.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    @Published var uiState: SignUpUIState = .none
    var publisher = PassthroughSubject<Bool, Never>()
    
    private var interactor: SignUpInteractor
    private var cancelableSignUp: AnyCancellable?
    private var cancelableSignIn: AnyCancellable?
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancelableSignUp?.cancel()
        cancelableSignIn?.cancel()
    }
    
    func signUp() {
        self.uiState = .loading
        
        // transform the string dd/MM/yyyy in Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormated = formatter.date(from: birthday)
        
        // date validation
        guard let dateFormated else {
            self.uiState = .error("Date invalid \(birthday)")
            return
        }
        
        // converting Date to string yyyy-MM-dd
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormated)
        
        let signUpRequest = SignUpRequest(
            fullName: fullName,
            email: email,
            document: document,
            phone: phone,
            gender: gender.index,
            birthday: birthday,
            password: password
        )
        
        cancelableSignUp = interactor.postUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                    
                case .finished:
                    break
                }
            } receiveValue: { created in
                if(created) {
                    self.cancelableSignIn = self.interactor.signIn(request: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion {
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                                
                            case .finished:
                                break
                            }
                        } receiveValue: { success in
                            print(success)
                            
                            let userAuth = UserAuth(
                                idToken: success.accessToken,
                                refreshToken: success.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                TokenType: success.tokenType
                            )
                            // saving values on local storage
                            self.interactor.insertAuth(userAuth: userAuth)
                            
                            self.uiState = .success
                            self.publisher.send(created)
                        }
                }
            }
    }
}


extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
