//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 06/01/25.
//

import Foundation
import Combine

class SignUpInteractor {
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
//    private let local: LocalDataSource = .shared
}

extension SignUpInteractor {
    func postUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppError>{
        return remoteSignUp.postUser(request: request)
    }
    func signIn(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.signIn(request: request)
    }
}
