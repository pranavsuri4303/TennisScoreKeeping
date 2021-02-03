//
//  TennisApp.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import Firebase
@main
struct TennisApp: App {
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
// Intializing FIrebase...

class Delegate : NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()

        return true
    }
    
}
