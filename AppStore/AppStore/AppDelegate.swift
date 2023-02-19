//
//  AppDelegate.swift
//  AppStore
//
//  Created by Rushi Bhatt on 11/14/20.
//  Copyright © 2020 Rushi Bhatt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
        let rootVC = FeaturedAppController(collectionViewLayout: layout)
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        
        
        return true
    }
}

