//
//  TodosApp.swift
//  Shared
//
//  Created by James Meli on 6/29/20.
//

import SwiftUI
import Firebase

@main
struct TodosApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                TaskListView().environmentObject(TaskStore())
            } else {
                WelcomeView()
            }
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
