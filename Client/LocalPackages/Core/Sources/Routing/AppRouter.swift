import UIKit

public final class AppRouter {

    private let navigationController: UINavigationController

    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController ?? Self.makeNavigationController()
    }

    private static func makeNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
}

extension AppRouter: Router {

    public func toPresent() -> UIViewController {
        return navigationController
    }

    public func present(_ viewController: UIViewController) {
        toPresent().present(viewController, animated: true, completion: nil)
    }

    public func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    public func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    public func setRoot(_ viewController: UIViewController) {
        setRoot(viewController, animated: false)
    }

    public func setRoot(_ viewController: UIViewController, animated: Bool) {
        navigationController.setViewControllers([viewController], animated: animated)
    }

    public func dismiss(_ completion: (() -> Void)?) {
        toPresent().dismiss(animated: true, completion: completion)
    }
}
