//
//  GenderSelectorView.swift
//  Habit
//
//  Created by Mateus Lopes on 27/04/25.
//

import SwiftUI

struct GenderSelectorView: View {
    let title: String
    let genders: [Gender]
    @Binding var selectedGender: Gender?
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.id) { item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {pGesture in
                        if (selectedGender != item) {
                            selectedGender = item
                        }
                    }
                }
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            GenderSelectorView(title: "Gender", genders: Gender.allCases, selectedGender: .constant(.female))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
