//
//  SignUpView.swift
//  iChat
//
//  Created by Mateus Lopes on 03/11/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: SignUpViewModel = SignUpViewModel()
    @State var isShowPhotoLibrary: Bool = false
    
    var body: some View {
        VStack {
            Button{
                isShowPhotoLibrary = true
            } label: {
                if viewModel.image.size.width > 0 {
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("GreenColor"), lineWidth: 4))
                        .shadow(radius: 7)
                } else {
                    Text("Photo")
                        .frame(width: 130, height: 130)
                        .padding()
                        .background(Color("GreenColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(100.0)
                }
            }
            .padding(.bottom, 32)
            .sheet(isPresented: $isShowPhotoLibrary){
                ImagePicker(selectedImage: $viewModel.image)
            }
            
            TextField("Name", text: $viewModel.name)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(
                            Color(UIColor.separator),
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.bottom, 10)
            
            TextField("E-mail", text: $viewModel.email)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(
                            Color(UIColor.separator),
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.bottom, 10)
                
            
            SecureField("Password", text: $viewModel.password)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(
                            Color(UIColor.separator),
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.bottom, 30)
            
         
            
            Button{
                viewModel.signUp()
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("GreenColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(24.0)
                }
            
                    
            }
            .alert(isPresented: $viewModel.formInvalid) {
                Alert(title: Text(viewModel.alertText))
            }
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 32)
        .background(Color.init(red: 240 / 255, green: 231 / 255, blue: 210 / 255))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SignUpView()
}
