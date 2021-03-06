//
//  SceneDelegate.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 10.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        LaunchManager.setupInitialViewController(for: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        NewsDAL.shared.saveContext()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        NewsDAL.shared.saveContext()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NewsDAL.shared.saveContext()
    }

}
