import UIKit
import Core
import ReSwift
import State
import Factory
import Models

final class DreamInfoCoordinator: BaseCoordinator, DreamInfoCoordinatorOutput {

    var finishFlow: (() -> Void)?

    private let router: Router
    private let dream: Dream

    init(router: Router, dream: Dream) {
        self.router = router
        self.dream = dream
    }

    override func start() {
        let viewController = DreamInfoViewController(
            dream: dream,
            imagePicker: ImagePicker(router: router)
        )
        viewController.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        router.push(viewController, animated: true)
    }

}
