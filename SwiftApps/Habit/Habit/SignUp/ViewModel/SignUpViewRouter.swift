//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Mateus Lopes on 27/10/24.
//

import SwiftUI

enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
