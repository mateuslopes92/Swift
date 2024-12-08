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
        
        // Main thread
        WebService.postUser(request: SignUpRequest(fullName: fullName, email: email, document: document, phone: phone, gender: gender.index, birthday: birthday, password: password)) { (successResponse, errorResponse) in
            
            // non main thread
            if let error = errorResponse {
                // Main thread
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            
            if let success = successResponse {
                WebService.signIn(request: SignInRequest(email: self.email, password: self.password)) {(successResponse, errorResponse) in
                    
                    // non main thread
                    if let errorSignIn = errorResponse {
                        // Main thread
                        DispatchQueue.main.async {
                            self.uiState = .error(errorSignIn.detail.message)
                        }
                    }
                    
                    if let successSignIn = successResponse {
                        DispatchQueue.main.async {
                            print(success)
                            self.publisher.send(success)
                            self.uiState = .success
                        }
                    }
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
