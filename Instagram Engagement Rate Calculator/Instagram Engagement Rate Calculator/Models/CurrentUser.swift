//
//  CurrentUser.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import SwiftUI

struct ErrorUser: Decodable {
    var success: Bool
    var message: String
}

struct CurrentUser: Decodable {
    var user_profile: UserProfile
}

struct UserProfile: Decodable {
    var username: String
    var picture: String
    var fullname: String
    var description: String?
    var followers: Int
    var posts_count: Int
    var avg_likes: Int
    var avg_comments: Int
    var avg_views: Int
    var engagement_rate: Double
    var contacts: Array<Contacts>?
}

struct Contacts: Decodable, Hashable {
    var type: String
    var value: String
}


