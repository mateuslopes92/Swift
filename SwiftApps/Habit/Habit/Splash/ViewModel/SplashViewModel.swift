//
//  SplashViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 16/10/24.
//

import SwiftUI
import Foundation
import Combine

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear() {
        print("onAppear")
        print(uiState)
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink{ userAuth in
                if(userAuth != nil){
                    print(userAuth!)
                }
                
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                }
                else if(Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    // call refresh token api
                    print("token expired")
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion){
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            let userAuth = UserAuth(
                                idToken: success.accessToken,
                                refreshToken: success.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                TokenType: success.tokenType
                            )
                            // saving values on local storage
                            self.interactor.insertAuth(userAuth: userAuth)
                            self.uiState = .goToHomeScreen
                        })
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        SplashViewRouter.makeSignInView()
    }
}
