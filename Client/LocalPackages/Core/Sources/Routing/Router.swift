import UIKit

public protocol Router {
    func toPresent() -> UIViewController

    func present(_ viewController: UIViewController)

    func push(_ viewController: UIViewController)
    func push(_ viewController: UIViewController, animated: Bool)

    func popViewController(animated: Bool)

    func setRoot(_ viewController: UIViewController)
    func setRoot(_ viewController: UIViewController, animated: Bool)

    func dismiss(_ completion: (() -> Void)?)
}
