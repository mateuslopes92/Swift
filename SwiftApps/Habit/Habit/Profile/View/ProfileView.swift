//
//  ProfileView.swift
//  Habit
//
//  Created by Mateus Lopes on 26/04/25.
//

import SwiftUI

struct ProfileView: View {
    @State var fullName = ""
    @State var email = "Testmateus@test.com"
    @State var cpf = "123.456.789-00"
    @State var phone = "(44) 98765-4321"
    @State var birthday = "27/03/1996"
    @State var selectedGender: Gender? = .male
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    Section(header: Text("Register Data")) {
                        HStack {
                            Text("Name")
                            Spacer()
                            TextField("Enter your name", text: $fullName)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.alphabet)
                        }
                        
                        HStack {
                            Text("Email")
                            Spacer()
                            TextField("", text: $email)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                                .disabled(true)
                        }
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
                                .disabled(true)
                        }
                        
                        HStack {
                            Text("Phone Number")
                            Spacer()
                            TextField("Enter your phone number", text: $phone)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        
                        HStack {
                            Text("Birthday")
                            Spacer()
                            TextField("Enter your birthday", text: $birthday)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        NavigationLink(
                            destination: GenderSelectorView(
                                            title: "Gender",
                                            genders: Gender.allCases,
                                            selectedGender: $selectedGender,
                            ),
                            label: {
                                HStack {
                                    Text("Gender")
                                    Spacer()
                                    Text(selectedGender?.rawValue ?? "")
                                }
                            }
                        )
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

