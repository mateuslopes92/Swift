//
//  HomeView.swift
//  Habit
//
//  Created by Mateus Lopes on 17/10/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text("Home View")
    }
}


#Preview {
    let viewModel = HomeViewModel()
    HomeView(viewModel: viewModel)
}

