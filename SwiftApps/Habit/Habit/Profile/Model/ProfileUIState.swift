//
//  ProfileUIState.swift
//  Habit
//
//  Created by Mateus Lopes on 10/06/25.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSucces
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
