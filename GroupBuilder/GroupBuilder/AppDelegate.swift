//
//  AppDelegate.swift
//  GroupBuilder
//
//  Created by ppc90 on 4/30/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    //===window - to get started. UIWIndow, rootViewController, makeKeyAndVisible req===//
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window!.rootViewController = LoginVC()
        
        self.window!.makeKeyAndVisible()
        
        return true
    }

    
}

