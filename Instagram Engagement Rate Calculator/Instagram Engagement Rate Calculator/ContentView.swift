//
//  ContentView.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 30/12/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                SignUpView()
            }else{
                MainView()
            }
        }
    }
}

