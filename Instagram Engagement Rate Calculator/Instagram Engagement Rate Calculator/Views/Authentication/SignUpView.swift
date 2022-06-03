//
//  LogInView.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import SwiftUI


struct SignUpView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
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
                                Text("Get Started")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.primaryColor)
                                    .padding()
                                    .padding(.bottom, 30)
                                VStack(spacing: 30){
                                    CustomTextField(placeholder: Text("Username"), image: "person", showsImg: true, text: $username)
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
                                Text("Sign Up")
                                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color.primaryColor)
                                Spacer()
                                Button {
                                    authViewModel.register(withEmail: email, password: password, username: username)
                                    authViewModel.fetchUser()
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
                               Text("If you already have account, you can")
                                NavigationLink {
                                    SignInView()
                                } label: {
                                    Text("Sign In")
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
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
