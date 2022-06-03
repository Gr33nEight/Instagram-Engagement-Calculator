//
//  MainView.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 05/01/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var user = UserProfile(username: "", picture: "", fullname: "", description: "" ,followers: 0, posts_count: 0, avg_likes: 0, avg_comments: 0, avg_views: 0, engagement_rate: 0, contacts: [Contacts(type: "", value: "")])
    @State var username = ""
    @State var show = false
    @State var isKeyboardShown = false
    @State var showProfileView = false
    @State var showBuyPointsView = false
    @State var success = true
    @State var errorMessage = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack{
            VStack{
                HStack(spacing: 10){
                    if !isKeyboardShown {
                        Button {
                            showProfileView = true
                        } label: {
                            Image(systemName: "person")
                                .font(.system(size: 20, weight: .semibold))
                            
                        }
                    }
                    CustomTextField(placeholder: Text("Write down the username"), image: "globe", showsImg: false, text: $username)
                        .onAppear(perform: {
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                                withAnimation {
                                    isKeyboardShown = true
                                }
                            }
                        })
                        .submitLabel(.done)
                        .onSubmit {
                            if authViewModel.currentUser!.points <= 0 {
                                success = false
                                errorMessage = "You don't have enough points!"
                                withAnimation {
                                    show = true
                                }
                            }else{
                                loadData()
                            }
                        }
                        .frame(height: 20)
                    
                    if !isKeyboardShown {
                        Button {
                            showBuyPointsView = true
                        } label: {
                            Text("Points: \(authViewModel.currentUser?.points ?? 0)")
                                .foregroundColor(.primaryColor)
                                .font(.system(size: 15, weight: .semibold))
                        }

                    }else{
                        Button {
                            withAnimation {
                                isKeyboardShown = false
                                UIApplication.shared.endEditing()
                            }
                        } label: {
                            Text("Cancel")
                                .font(.system(size: 15, weight: .semibold))
                        }
                        
                    }
                }
                Spacer()
                VStack{
                    if !isKeyboardShown && !show {
                        Text("Who are you looking for?")
                            .padding(.bottom, 40)
                            .padding()
                            .foregroundColor(.primaryColor)
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Image("img")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .scaledToFit()
                    } else {
                        if show {
                            if success {
                                ProfileView(user: user, isShown: $isKeyboardShown)
                                    .onAppear {
                                        authViewModel.removePoint()
                                    }
                            }else {
                                Text("Something went wrong: \(errorMessage).")
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 40)
                                    .padding()
                                    .foregroundColor(.primaryColor)
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                Image("img2")
                                    .resizable()
                                    .frame(width: 250, height: 250)
                                    .scaledToFit()
                            }
                        }else{
                            EmptyView()
                                .onTapGesture {
                                    withAnimation {
                                        isKeyboardShown = false
                                        UIApplication.shared.endEditing()
                                    }
                                }
                        }
                    }
                }.onTapGesture {
                    withAnimation {
                        isKeyboardShown = false
                        UIApplication.shared.endEditing()
                    }
                }
                Spacer()
            }.padding()
            
            
        }.fullScreenCover(isPresented: $showProfileView) {
            CurrentUserProfileSettings(show: $showProfileView)
        }
        .fullScreenCover(isPresented: $showBuyPointsView) {
            BuyPointsView(show: $showBuyPointsView)
        }
    }
    func loadData() {
        
        if username.isEmpty{
            success = false
            errorMessage = "You have to write a username"
        }else if username.contains(" ") {
            success = false
            errorMessage = "You can't leave space in a username"
        }else{
            withAnimation {
                success = true
            }
            
            guard let url = URL(string: "https://grin.co/wp-admin/admin-ajax.php?action=imc_engagement&imc_url=\(username)") else {
                success = false
                errorMessage = "Invalid URL"
                fatalError("Missing URL")
            }

            do {
                let data = try Data(contentsOf: url)
                
                if let decodeUser = try? JSONDecoder().decode(ErrorUser.self, from: data){
                    withAnimation {
                        success = decodeUser.success
                    }
                    errorMessage = decodeUser.message
                }
                
            }catch{
                success = false
                errorMessage = "Invalid data"
            }
            
                let urlRequest = URLRequest(url: url)

                let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let error = error {
                        print("Request error: ", error)
                        return
                    }

                    guard let response = response as? HTTPURLResponse else { return }

                    if response.statusCode == 200 {
                        guard let data = data else { return }
                        DispatchQueue.main.async {
                            do {
                                let decodedUser = try JSONDecoder().decode(CurrentUser.self, from: data)
                                user = decodedUser.user_profile
                            } catch let error {
                                print("Error decoding: ", error)
                            }
                        }
                    }
                }

                dataTask.resume()
        }
        withAnimation {
            show = true
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
