//
//  SceneDelegate.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                window.rootViewController = LoginViewController()
            } else {
                let tabBarController = TabBarController()
                tabBarController.selectedIndex = 1
                window.rootViewController = tabBarController
            }
        }
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
    }
}

