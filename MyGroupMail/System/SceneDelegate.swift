//
//  SceneDelegate.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let context = CoreDataStack.shared.container.viewContext
        let contentView = HomeView().environment(\.managedObjectContext, context)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let hostingVC = UIHostingController(rootView: contentView)
            let mainNavVC = UINavigationController(rootViewController: hostingVC)
            mainNavVC.navigationBar.isHidden = true
            window.rootViewController = mainNavVC
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
