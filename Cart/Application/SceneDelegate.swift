//
//  SceneDelegate.swift
//  Cart
//
//  Created by Andrey Volobuev on 22/04/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(windowScene: scene)
        window?.windowScene = scene
        let veiwController = CartViewController(ProductItemsRepository(), imagesService: ImagesService())
        window?.rootViewController = UINavigationController(rootViewController: veiwController)
        window?.makeKeyAndVisible()
    }
}

