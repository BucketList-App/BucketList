//
//  AppDelegate.swift
//  BucketList
//
//  Created by Gleb Fandeev on 18.09.2023.
//

import Core
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let assembler = AppAssembler()

    // swiftlint:disable discouraged_optional_collection
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let appCoordinator = assembler.makeAppCoordinator()
        let router = assembler.makeAppRouter()

        appCoordinator.start()

        window?.rootViewController = router.toPresent()
        window?.makeKeyAndVisible()

        return true
    }

}
