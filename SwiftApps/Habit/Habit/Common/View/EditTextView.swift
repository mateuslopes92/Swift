//
//  EditTextView.swift
//  Habit
//
//  Created by Mateus Lopes on 03/11/24.
//

import SwiftUI

struct EditTextView: View {
    @Binding var text: String
    
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autoCapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .foregroundColor(Color("textColor"))
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .foregroundColor(Color("textColor"))
                    .textFieldStyle(CustomTextFieldStyle())
                    .autocapitalization(autoCapitalization)
            }
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack {
                EditTextView(text: .constant("test"), placeholder: "Email", error: "Invalid").padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
        }
    }
}
