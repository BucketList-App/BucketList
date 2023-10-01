//
//  AppDelegate.swift
//  BucketList
//
//  Created by Gleb Fandeev on 18.09.2023.
//

import UIKit
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationCon = UINavigationController.init()
        appCoordinator = DreamsCoordinator()
        appCoordinator?.presentingController = navigationCon
        appCoordinator!.start()
        window!.rootViewController = navigationCon
        window!.makeKeyAndVisible()
        return true
    }

}
