//
//  Instagram_Engagement_Rate_CalculatorApp.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 30/12/2021.
//

import SwiftUI
import Firebase

@main
struct Instagram_Engagement_Rate_CalculatorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var storeManager = StoreManager(authViewModel: AuthViewModel.shared)
    
    let productIDs = [
        "100",
        "300",
        "1000",
        "2500",
        "5200",
        "10000"
    ]
    
    init(){
        Firebase.FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
                .environmentObject(storeManager).onAppear(perform: {storeManager.getProducts(productIDs: productIDs)
                    print(storeManager.myProducts)})
                
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // something to do
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window:UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
