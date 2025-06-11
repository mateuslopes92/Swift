//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Mateus Lopes on 28/04/25.
//
import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchUser() {
        self.uiState = .loading
        
        cancellable = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.userId = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullName
                self.phoneValidation.value = response.phone
                
                // transform the string dd/MM/yyyy in Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                let dateFormated = formatter.date(from: response.birthday)
                
                // date validation
                guard let dateFormated else {
                    self.uiState = .fetchError("Date invalid \(response.birthday)")
                    return
                }
                
                // converting Date to string yyyy-MM-dd
                formatter.dateFormat =  "dd/MM/yyyy"
                let birthday = formatter.string(from: dateFormated)
                
                self.birthdayValidation.value = birthday
                
                self.uiState = .fetchSucces
            })
    }
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
