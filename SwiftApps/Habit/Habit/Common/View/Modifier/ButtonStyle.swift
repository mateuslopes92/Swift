//
//  ButtonStyle.swift
//  Habit
//
//  Created by Mateus Lopes on 27/01/25.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.orange)
            .foregroundStyle(.white)
            .cornerRadius(8)
    }
}
