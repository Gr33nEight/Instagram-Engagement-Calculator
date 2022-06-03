//
//  BuyPointsView.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 05/01/2022.
//

import SwiftUI

struct BuyPointsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var storeManager: StoreManager
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack{
            Image("fullBg")
                .resizable()
                .frame(width: screenW)
                .scaledToFit()
                .ignoresSafeArea()
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                VStack{
                    HStack{
                        Text("Your points:")
                            .foregroundColor(.primaryColor)
                            .underline(true, color: .thirdColor)
                        Text("\(authViewModel.currentUser?.points ?? 0)")
                            .foregroundColor(.secondary)
                            .underline(true, color: .thirdColor)
                    }.font(.system(size: 27, weight: .semibold, design: .rounded))
                    .padding()
                    .padding(.top, 10)
                    
                    Text("Do you want to buy more points?")
                        .padding(.bottom)
                        .padding()
                        .foregroundColor(.secondaryColor)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                    Image("img3")
                        .resizable()
                        .frame(width: 220, height: 220)
                        .scaledToFit()
                    ScrollView(showsIndicators: false){
                        VStack{
                            ForEach(storeManager.myProducts.sorted(by: { (p0, p1) in
                                p0.price.floatValue < p1.price.floatValue
                            }), id:\.self){ product in
                                Button {
                                    storeManager.purchaseProduct(product: product)
                                    
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.thirdColor)
                                            .frame(height: 50)
                                        HStack{
                                            Text("\(product.localizedTitle)")
                                                .foregroundColor(.primaryColor)
                                            Spacer()
                                            Text("\(product.localizedPrice)")
                                                .foregroundColor(.secondary)
                                        }.font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .padding()
                                        
                                    }.padding(.horizontal)
                                }
                            }

                        }.padding(.top, 30)
                    }
                    Spacer()
                }.overlay(
                    Button(action: {
                        show = false
                    }, label: {
                        ZStack{
//                            Circle()
//                                .fill(Color.thirdColor)
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20, weight: .semibold))
                        }.frame(width: 50, height: 50)
                            //.offset(x: 10, y:)
                    })
                        
                    , alignment: .topLeading
                )
            }.padding(15)
        }
    }
}
