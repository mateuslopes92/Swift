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
        if viewModel.isLogged {
            // Message screen
            Text("Message app")
        } else {
            SignInView()
        }
    }
}

#Preview {
    ContentView()
}
