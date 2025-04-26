//
//  ProfileView.swift
//  Habit
//
//  Created by Mateus Lopes on 26/04/25.
//

import SwiftUI

struct ProfileView: View {
    @State var fullName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    Section(header: Text("Register Data")) {
                        HStack {
                            Text("Name:")
                            TextField("Enter your name", text: $fullName)
                        }
                    }
                }
                
            }.navigationBarTitle(Text("Edit Profile"), displayMode: .automatic)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            ProfileView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}

