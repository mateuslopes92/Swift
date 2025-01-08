//
//  SignInInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 09/12/24.
//
import Foundation
import Combine

// in kotlin for instance a interactor is called repository
class SignInInteractor {
    private let remote: SignInRemoteDataSource = .shared
//    private let local: LocaleDataSource
}

extension SignInInteractor {
    func signIn(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.signIn(request: request)
    }
}
