//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Mateus Lopes on 03/11/24.
//

import SwiftUI

struct LoadingButtonView: View {
    var text: String = ""
    var action: () -> Void
    var disabled: Bool = false
    var showProgress: Bool = false

    var body: some View {
        ZStack{
            Button(
                action: {
                    action()
                },
                label: {
                    Text(showProgress ? " " : text)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .font(Font.system(.title3).bold())
                        .background(disabled ? Color("lightOrange") : Color.orange)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }
            ).disabled(disabled || showProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack {
                LoadingButtonView(text: "Entrar", action: {
                    print("Hello, World!")
                }, disabled: false, showProgress: false).padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
        }
    }
}
