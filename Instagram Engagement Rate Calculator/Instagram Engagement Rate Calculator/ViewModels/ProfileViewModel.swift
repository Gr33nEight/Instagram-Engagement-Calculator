//
//  ProfileViewModel.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 01/01/2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    static let shared = ProfileViewModel()
    
    @Published public var isKeyboardShown = false
}
