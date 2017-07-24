//
//  AppDelegate.swift
//  TinkoffNews
//
//  Created by jufina on 21.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        _ = CoreDataStack {}
        
        showInitialModule()
        
        return true
    }
    
    fileprivate func showInitialModule() {
        let postsList = PostListRouter.postListModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = postsList
        window?.makeKeyAndVisible()
    }
}

