//
//  ProfileEditTextView.swift
//  Habit
//
//  Created by Mateus Lopes on 11/09/25.
//
import Foundation
import SwiftUI

struct ProfileEditTextView: View {
    @Binding var text: String
    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboardType: UIKeyboardType = .default
    var autoCapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .foregroundColor(Color("textColor"))
                .autocapitalization(autoCapitalization)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { value in
                    if let mask = mask {
                        Mask.mask(mask: mask, value: value, text: &text)
                    }
                }
        }
        .padding(.bottom, 10)
    }
}

struct ProfileEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack {
                ProfileEditTextView(text: .constant("test"), placeholder: "Email").padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
        }
    }
}
