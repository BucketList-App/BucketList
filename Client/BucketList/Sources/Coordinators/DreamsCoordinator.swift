import UIKit
import Core
import ReSwift
import State
import Factory

final class DreamsCoordinator: Coordinator {

    weak var presentingController: UIViewController?

    @Injected(\.store) private var store: Store<AppState>

    func start() {
        let dreamsVC = DreamListViewController()
        presentingController?.present(dreamsVC, animated: true)
    }

}
