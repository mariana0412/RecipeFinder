//
//  SceneDelegate.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 08.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = RecipeViewController(recipe: Recipe(name: "nastia sweet"))
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

