//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Mateus Lopes on 15/10/24.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView() -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
}
