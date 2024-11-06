//
//  CustomTextStyle.swift
//  Habit
//
//  Created by Mateus Lopes on 03/11/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.orange, lineWidth: 0.8)
            )
    }
}
