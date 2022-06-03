//
//  CustomSecureField.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import SwiftUI

struct CustomSecureField: View {
    let placeholder: Text
    let image: String
    
    @State var isSecured: Bool = true
    @Binding var text: String
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.04)
                .cornerRadius(20)
                .frame(height: 70)
            HStack{
                Image(systemName: image)
                    .padding(.horizontal)
                    .font(.title)
                    .foregroundColor(Color.secondaryColor)
                ZStack(alignment: .leading){
                    if text.isEmpty{
                        placeholder
                            .foregroundColor(Color.black.opacity(0.2))
                    }
                    if isSecured{
                        SecureField("", text: $text)
                    }else{
                        TextField("", text: $text)
                    }
                }
                Spacer()
                Button {
                    isSecured.toggle()
                } label: {
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(Color.secondaryColor)
                }

            }.padding()
            
        }
    }
}


