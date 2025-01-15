//
//  SplashInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 14/01/25.
//
import Foundation
import Combine

// in kotlin for instance a interactor is called repository
class SplashInteractor {
//    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    func fetchAuth() -> Future<UserAuth?, Never>{
        local.getUserAuth()
    }
}
