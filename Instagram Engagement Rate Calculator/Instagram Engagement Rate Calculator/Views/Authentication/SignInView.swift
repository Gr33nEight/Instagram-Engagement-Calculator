//
//  SignInView.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var authViewModel : AuthViewModel
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenW, height: screenH)
                    .ignoresSafeArea()
                ZStack{
                    Color.white
                        .cornerRadius(50)
                    
                    VStack{
                        ScrollView(showsIndicators: false){
                            VStack(alignment: .leading){
                                Text("Welcome back")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.primaryColor)
                                    .padding()
                                    .padding(.bottom, 30)
                                VStack(spacing: 30){
                                    CustomTextField(placeholder: Text("Email"), image: "envelope", showsImg: true, text: $email)
                                    CustomSecureField(placeholder: Text("Password"), image: "lock", text: $password)
                                }
                                Spacer()
                            }.padding()
                                .padding(.top, 10)
                            
                        }
                        Spacer()
                        VStack{
                            HStack{
                                Text("Sign In")
                                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color.primaryColor)
                                Spacer()
                                Button {
                                    authViewModel.login(withEmail: email, password: password)
                                } label: {
                                    ZStack{
                                        Circle()
                                            .fill(Color.primaryColor)
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .semibold))
                                    }.frame(width: 60, height: 60)
                                }

                                
                            }
                            HStack{
                               Text("If you don't have account, you can")
                                Button {
                                    mode.wrappedValue.dismiss()
                                } label: {
                                    Text("Sign Up")
                                        .underline(color: Color.primaryColor)
                                        .foregroundColor(Color.primaryColor)
                                }
                                Text("here")
                            }.font(.system(size: 12))
                                .padding(.top, 5)
                                

                        }.padding(.bottom, 30)
                            .padding(.horizontal, 30)
                            .foregroundColor(Color.black.opacity(0.2))
                        
                    }
                }.frame(height: screenH/1.5, alignment: .bottom)
            }.navigationBarHidden(true)
        }.navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
