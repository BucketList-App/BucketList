import UIKit
import Core
import ReSwift
import State
import Models

final class DreamInfoCoordinator: BaseCoordinator, DreamInfoCoordinatorOutput {

    var finishFlow: (() -> Void)?

    private let store: Store<AppState>
    private let router: Router
    private let dream: Dream

    init(
        store: Store<AppState>,
        router: Router,
        dream: Dream
    ) {
        self.store = store
        self.router = router
        self.dream = dream
    }

    override func start() {
        let viewController = DreamInfoViewController(
            store: store,
            dream: dream,
            imagePicker: ImagePicker(router: router)
        )
        viewController.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        router.push(viewController, animated: true)
    }

}
