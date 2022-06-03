//
//  User.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import FirebaseFirestoreSwift

struct User : Identifiable, Decodable {
    let username: String
    let email: String
    var points = 1
    @DocumentID var id: String?
}

