import UIKit
import Core
import ReSwift
import State
import Factory

final class DreamInfoCoordinator: BaseCoordinator {

    private let router: Router

    init(router: Router) {
        self.router = router
    }

    override func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .brown
        router.push(viewController, animated: true)
    }

}
