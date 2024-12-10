//
//  SignInInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 09/12/24.
//
import Foundation

// in kotlin for instance a interactor is called repository
class SignInInteractor {
    private let remote: RemoteDataSource = .shared
//    private let local: LocaleDataSource
}

extension SignInInteractor {
    func signIn(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void){
        remote.signIn(request: request, completion: completion)
    }
}
