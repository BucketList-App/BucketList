import UIKit
import Core
import ReSwift
import State

final class DreamsCoordinator: Coordinator {

    weak var presentingController: UIViewController?

    private let store: Store<AppState>

    init(store: Store<AppState>) {
        self.store = store
    }

    func start() {
        let dreamsVC = DreamListViewController(store: store)
        presentingController?.present(dreamsVC, animated: true)
    }

}
