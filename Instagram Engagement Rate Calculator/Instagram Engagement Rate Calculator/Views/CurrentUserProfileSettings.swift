//
//  CurrentUserProfileSettings.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 05/01/2022.
//

import SwiftUI

struct CurrentUserProfileSettings: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: .bottom){
            Image("bg")
                .resizable()
                .scaledToFill()
                .frame(width: screenW, height: screenH)
                .ignoresSafeArea()
            VStack{
                Spacer()
                ZStack{
                    Color.white
                        .cornerRadius(50)
                    VStack{
                        Text("Hello!")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                            .padding(30)
                        VStack(spacing: 20){
                            HStack{
                                Text("Username:")
                                    .foregroundColor(.secondaryColor)
                                    .font(.system(size: 18, weight: .regular, design: .rounded))
                                Text(authViewModel.currentUser?.username ?? "error")
                                    .foregroundColor(.accentColor)
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                Spacer()
                            }

                            HStack{
                                Text("Email:")
                                    .foregroundColor(.secondaryColor)
                                    .font(.system(size: 18, weight: .regular, design: .rounded))
                                Text(authViewModel.currentUser?.email ?? "error")
                                    .foregroundColor(.accentColor)
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                Spacer()
                            }
                            
                            HStack{
                                Text("Number of points:")
                                    .foregroundColor(.secondaryColor)
                                    .font(.system(size: 18, weight: .regular, design: .rounded))
                                Text("\(authViewModel.currentUser?.points ?? 0)")
                                    .foregroundColor(.accentColor)
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                Spacer()
                            }
                            Spacer()
                            Button {
                                authViewModel.signout()
                            } label: {
                                ZStack{
                                    Color.secondaryColor
                                        .frame(height: 70)
                                    Text("Sign Out")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }.cornerRadius(20)
                            }

                        }.padding()
                        Spacer()
                    }
                    
                }.frame(height: screenH/1.2, alignment: .bottom)
            }
            
        }
        .overlay(
            Button(action: {
                show = false
            }, label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.black)
                    .font(.system(size: 20, weight: .semibold))
                    
            }).padding(30)
            , alignment: .topLeading
        )
    }
}
