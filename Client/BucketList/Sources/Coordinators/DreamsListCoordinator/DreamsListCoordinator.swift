import UIKit
import Core
import ReSwift
import State
import Factory
import Models

final class DreamsListCoordinator: BaseCoordinator, DreamsListCoordinatorOutput {

    var finishFlow: (() -> Void)?

    @Injected(\.store) private var store: Store<AppState>
    private let router: Router
    private let coordinatorsFactory: CoordinatorsFactory
    private let dreamListThunkFactory: DreamListThunkFactory

    init(
        router: Router,
        coordinatorsFactory: CoordinatorsFactory,
        dreamListThunkFactory: DreamListThunkFactory
    ) {
        self.router = router
        self.coordinatorsFactory = coordinatorsFactory
        self.dreamListThunkFactory = dreamListThunkFactory
    }

    override func start() {
        let dreamsVC = DreamListViewController(dreamListThunkFactory: dreamListThunkFactory)
        dreamsVC.openDream = { [weak self] dream in
            self?.runDreamInfoCoordinator(dream: dream)
        }
        router.push(dreamsVC, animated: true)
    }

    private func runDreamInfoCoordinator(dream: Dream) {
        var dreamInfoCoordinator = self.coordinatorsFactory.makeDreamInfoCoordinator(dream: dream)
        dreamInfoCoordinator.finishFlow = { [weak self] in
            self?.removeDependency(dreamInfoCoordinator)
        }

        dreamInfoCoordinator.start()
        addDependency(dreamInfoCoordinator)
    }

}
