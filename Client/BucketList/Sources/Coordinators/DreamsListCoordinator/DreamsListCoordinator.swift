import Core
import Models
import ReSwift
import State
import UIKit

final class DreamsListCoordinator: BaseCoordinator, DreamsListCoordinatorOutput {

    var finishFlow: (() -> Void)?

    private let store: Store<AppState>
    private let router: Router
    private let coordinatorsFactory: CoordinatorsFactory
    private let dreamListThunkFactory: DreamListThunkFactory

    init(
        store: Store<AppState>,
        router: Router,
        coordinatorsFactory: CoordinatorsFactory,
        dreamListThunkFactory: DreamListThunkFactory
    ) {
        self.store = store
        self.router = router
        self.coordinatorsFactory = coordinatorsFactory
        self.dreamListThunkFactory = dreamListThunkFactory
    }

    override func start() {
        let viewModel = DreamListViewModel(
            store: store,
            dreamListThunkFactory: dreamListThunkFactory
        )
        let cellDI = CellDI(
            store: store,
            dreamListThunkFactory: dreamListThunkFactory
        )
        let dreamsVC = DreamListViewController(
            store: store,
            viewModel: viewModel,
            cellDI: cellDI
        )
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
