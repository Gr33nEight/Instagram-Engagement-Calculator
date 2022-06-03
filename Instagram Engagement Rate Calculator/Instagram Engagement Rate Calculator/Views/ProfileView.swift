//
//  ProfileView.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 05/01/2022.
//

import SwiftUI

struct ProfileView: View {
    let user: UserProfile
    @Binding var isShown: Bool
    
    let formatter = AbbreviatedNumberFormatter()
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.thirdColor)
                .shadow(radius: 10)
                .frame(width: isShown ? 320 : .infinity, height: isShown ? 320 : .infinity)
            HStack{
                VStack{
                    Spacer()
                    if !isShown {
                        ScrollView(showsIndicators: false){
                            VStack(alignment: .leading, spacing: 20){
                                HStack{
                                    Text("Fullname: ")
                                        .foregroundColor(.secondaryColor)
                                        .bold()
                                    Text("\(user.fullname)")
                                }
                                HStack{
                                    Text("Description: ")
                                        .foregroundColor(.secondaryColor)
                                        .bold()
                                    Text("\(user.description ?? "")")
                                }
                                HStack{
                                    Text("Followers: ")
                                        .foregroundColor(.secondaryColor)
                                        .bold()
                                    Text(formatter.string(from: user.followers))
                                }
                                HStack{
                                    Text("AVG likes: ")
                                        .foregroundColor(.secondaryColor)
                                        .bold()
                                    Text(formatter.string(from: user.avg_likes))
                                }
                                HStack{
                                    Text("AVG comments: ")
                                        .foregroundColor(.secondaryColor)
                                        .bold()
                                    Text(formatter.string(from: user.avg_comments))
                                }
                                HStack{
                                    Text("AVG views: ")
                                        .foregroundColor(.secondaryColor)
                                        .bold()
                                    Text(formatter.string(from: user.avg_views))
                                }
                                HStack{
                                    Text("Engagement rate: ")
                                        .foregroundColor(.secondaryColor)
                                        .bold()
                                    Text("\((user.engagement_rate*100), specifier: "%.2f")%")
                                }
                                ForEach(user.contacts ?? [Contacts(type: "", value: "")], id:\.self){ contact in
                                    HStack{
                                        if !contact.type.isEmpty {
                                            if contact.type == "phone"{
                                                Text("\(contact.type): ")
                                                    .foregroundColor(.secondaryColor)
                                                    .bold()
                                                Text("\(contact.value)")
                                            }else{
                                                
                                            }
                                        }
                                    }
                                }
                            }.padding(.horizontal)
                        }.padding(.top, screenH/5)
                    }
                }
                Spacer()
            }.padding(.horizontal)
            VStack{
                VStack{
                    AsyncImage(
                        url: URL(string: user.picture) ?? URL(string: "https://developers.google.com/maps/documentation/maps-static/images/error-image-generic.png?hl=da"),
                        content: { image in
                            image.resizable()
                                .interpolation(Image.Interpolation.high)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                            
                        },
                        placeholder: {
                            ProgressView()
                                .frame(width: 200, height: 200)
                        }
                    )
                    Text("@\(user.username)")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .foregroundColor(.primaryColor)
                        .padding()
                    if !isShown{
                        VStack{
                            Spacer()
                        }
                    }
                }
                
            }.offset(y: isShown ? 0 : -100)
        }.padding(10)
            .padding(.top, isShown ? 20 : 120)
    }
}
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
