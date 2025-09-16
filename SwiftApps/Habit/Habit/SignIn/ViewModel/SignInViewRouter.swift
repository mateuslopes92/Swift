//
//  SignInViewRouter.swift
//  Habit
//
//  Created by Mateus Lopes on 17/10/24.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    static func makeHomeView(homeViewModel: HomeViewModel) -> some View {
        return HomeView(viewModel: homeViewModel)
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
}
