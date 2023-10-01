import UIKit
import Core
import ReSwift
import State
import Factory

final class DreamsCoordinator: Coordinator {

    weak var presentingController: UINavigationController?

    @Injected(\.store) private var store: Store<AppState>

    func start() {
        let dreamsVC = DreamListViewController()
        let viewController = UIViewController()
        viewController.view.backgroundColor = .brown
        dreamsVC.openDream = { [weak self] in
            self?.presentingController?.present(viewController, animated: true)
        }
        presentingController?.pushViewController(dreamsVC, animated: true)
    }

}
