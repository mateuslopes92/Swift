//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Mateus Lopes on 10/06/25.
//

import Foundation
import Combine

class ProfileInteractor {
    private let remoteProfile: ProfileRemoteDataSource = .shared
}

extension ProfileInteractor {
    func fetchUser() -> Future<ProfileResponse, AppError>{
        return remoteProfile.fetchUser()
    }
    
    func updateUser(userId: Int, profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError>{
        return remoteProfile.updateUser(userId: userId, request: profileRequest)
    }
}

