//
//  ContentView.swift
//  iChat
//
//  Created by Mateus Lopes on 12/01/26.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLogged {
                MessagesView()
            } else {
                SignInView()
            }
        }.onAppear{
            viewModel.onAppear()
        }
    }
}

#Preview {
    ContentView()
}
