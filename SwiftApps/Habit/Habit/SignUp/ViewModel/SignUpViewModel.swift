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
        
        WebService.postUser(fullName: fullName, email: email, document: document, phone: phone, gender: gender.index, birthday: birthday, password: password)
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
         //   self.uiState = .success
         //   self.publisher.send(true)
        //}
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
