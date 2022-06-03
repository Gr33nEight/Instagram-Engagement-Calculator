//
//  CustomTextField.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import SwiftUI

struct CustomTextField: View {
    
    let placeholder: Text
    let image: String
    let showsImg: Bool
    
    @Binding var text: String
    
    var body: some View {
        HStack{
            if showsImg {
                Image(systemName: image)
                    .padding(.horizontal)
                    .font(.title)
                    .foregroundColor(Color.secondaryColor)
            }
            ZStack(alignment: .leading){
                if text.isEmpty{
                    placeholder
                        .lineLimit(1)
                        .foregroundColor(Color.black.opacity(0.2))
                }
                TextField("", text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
            }
            Spacer()
        }.padding()
            .background(
                Color.black.opacity(0.04)
                    .cornerRadius(20)
                    .frame(height: 70)
            )
    }
}
