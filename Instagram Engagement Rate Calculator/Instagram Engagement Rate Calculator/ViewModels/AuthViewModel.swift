//
//  AuthViewModel.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import StoreKit

class AuthViewModel : ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?

    static let shared = AuthViewModel()

    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
        print(currentUser?.username ?? "aaaaaa")
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
        }
    }

    func register(withEmail email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let user = result?.user else {return}
            let data = ["email" : email,
                        "username" : username,
                        "points": 1,
                        "uid" : user.uid
            ] as [String : Any]
            Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                self.userSession = user
                self.fetchUser()
            }
        }
    }

    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }

    func fetchUser() {
        guard let uid = userSession?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if error == nil {
                guard let user = try? snapshot?.data(as: User.self) else {return}
                self.currentUser = user
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func addPoint(product: SKProduct) {
        guard let boughtPoints = product.localizedTitle.parseToInt() else {return}
        guard let uid = userSession?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).updateData(["points" : FieldValue.increment(Int64(boughtPoints))])
        
        fetchUser()
    }
    
    func removePoint() {
        guard let uid = userSession?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).updateData(["points" : FieldValue.increment(Int64(-1))])
        
        fetchUser()
    }
}
