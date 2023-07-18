//
//  SolveIt.swift
//  SolveIt
//
//  Created by Daniel Feler on 12/12/22.
//

import SwiftUI
import Firebase
import GoogleSignIn


@main
struct SolveIt: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("logStatus") var logStatus: Bool?
    @AppStorage("guestMode") var guestMode = false
    var body: some Scene {
        WindowGroup {
            if logStatus == true && guestMode == false {
                MainTabView()
            } else {
                InitialView()
            }
            
        }
    }
}

class AppDelegate:  UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}


















