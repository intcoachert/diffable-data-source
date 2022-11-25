//
//  SceneDelegate.swift
//  DiffableDataSource
//
//  Created by Александр Пахомов on 25.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let viewController = RootViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
