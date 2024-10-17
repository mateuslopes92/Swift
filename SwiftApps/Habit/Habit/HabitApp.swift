//
//  HabitApp.swift
//  Habit
//
//  Created by Mateus Lopes on 08/01/24.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
