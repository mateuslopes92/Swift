//
//  SplashViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 16/10/24.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // dispatch after 2 secs
            self.uiState = .goToSignInScreen
        }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        SplashViewRouter.makeSignInView()
    }
}
