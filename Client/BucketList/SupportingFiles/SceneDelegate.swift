//
//  SceneDelegate.swift
//  BucketList
//
//  Created by Gleb Fandeev on 18.09.2023.
//

import UIKit
import ReSwift
import State

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let rootViewController = DreamListViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

}
