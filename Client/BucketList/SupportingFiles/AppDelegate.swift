//
//  AppDelegate.swift
//  BucketList
//
//  Created by Gleb Fandeev on 18.09.2023.
//

import UIKit
import Core
import Factory

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = Container.shared.appCoordinator.resolve()
        appCoordinator?.start()

        let router = Container.shared.appRouter.resolve()
        window!.rootViewController = router.toPresent()
        window!.makeKeyAndVisible()
        return true
    }

}
