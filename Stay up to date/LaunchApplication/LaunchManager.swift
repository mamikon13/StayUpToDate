//
//  LaunchManager.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 09.05.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


final class LaunchManager {
    
    // MARK: - Singletone
    
    static let shared = LaunchManager()
    
    private init() { }
    
    /// Setups an initial view controller for the given UIWindow
    ///
    /// - Parameters:
    ///   - window: The window the initial view controller will be attached as root view controller to.
    static func setupInitialViewController(for window: UIWindow?) {
        let vc = StoriesViewController()
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

}
