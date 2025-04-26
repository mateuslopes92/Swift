//
//  HomeView.swift
//  Habit
//
//  Created by Mateus Lopes on 17/10/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Habits")
                }.tag(0)
            
            Text("Graph Content \(selection)")
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Graphs")
                }.tag(1)
            
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }.tag(1)
        }
        .background(.white)
        .accentColor(.orange)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .lightOrange
             UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
         })
    }
}


#Preview {
    let viewModel = HomeViewModel()
    HomeView(viewModel: viewModel)
}

