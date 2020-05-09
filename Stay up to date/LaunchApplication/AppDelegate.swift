//
//  AppDelegate.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 10.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard #available(iOS 13.0, *) else {
            window = UIWindow(frame: UIScreen.main.bounds)
            LaunchManager.setupInitialViewController(for: window)
            return true
        }
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NewsDAL.shared.saveContext()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        NewsDAL.shared.saveContext()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        NewsDAL.shared.saveContext()
    }

}

