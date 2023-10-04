import UIKit
import Core
import ReSwift
import State
import Factory

final class DreamsListCoordinator: BaseCoordinator {

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
        let dreamInfoCoordinator = coordinatorsFactory.makeDreamInfoCoordinator()
        dreamsVC.openDream = {
            dreamInfoCoordinator.start()
        }
        router.push(dreamsVC, animated: true)
    }

}
