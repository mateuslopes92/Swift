//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 28/04/25.
//
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "Mateus Lopes" {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "1234567890" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "27/03/1996" {
        didSet {
            failure = value.count != 10
        }
    }
}
