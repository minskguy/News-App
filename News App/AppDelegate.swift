//
//  AppDelegate.swift
//  News App
//
//  Created by Марк Курлович on 1/19/21.
//  Copyright © 2021 Марк Курлович. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationViewController = UINavigationController()
        let coordinator = AppCoordinator(navigationController: navigationViewController)
        coordinator.start()
        
        window = UIWindow()
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

