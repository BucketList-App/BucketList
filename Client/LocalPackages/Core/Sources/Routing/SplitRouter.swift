//
//  SplitRouter.swift
//  
//
//  Created by Gleb Fandeev on 06.11.2023.
//

import UIKit

// Сделать сплит для landscape режима
public final class SplitRouter {

    private let splitController: UISplitViewController

    public init(splitController: UISplitViewController) {
        self.splitController = splitController
    }
}

extension SplitRouter: Router {

    public func toPresent() -> UIViewController {
        return splitController
    }

    public func present(_ viewController: UIViewController) {
        toPresent().present(viewController, animated: true, completion: nil)
    }

    public func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        splitController.showDetailViewController(viewController, sender: nil)
    }

    public func popViewController(animated: Bool) {
    }

    public func setRoot(_ viewController: UIViewController) {
        setRoot(viewController, animated: false)
    }

    public func setRoot(_ viewController: UIViewController, animated: Bool) {
    }

    public func dismiss(_ completion: (() -> Void)?) {
        toPresent().dismiss(animated: true, completion: completion)
    }
}
