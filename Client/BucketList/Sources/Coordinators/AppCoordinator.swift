import UIKit
import Core
import ReSwift
import State
import Factory

final class AppCoordinator: BaseCoordinator {

    @Injected(\.store) private var store: Store<AppState>

    private let router: Router
    private let coordinatorsFactory: CoordinatorsFactory
    private let launchInstructor = LaunchInstructor()

    init(router: Router, coordinatorsFactory: CoordinatorsFactory) {
        self.router = router
        self.coordinatorsFactory = coordinatorsFactory
    }

    override func start() {
        switch launchInstructor {
        case .main:
            runMainFlow()
        }
    }

}

private extension AppCoordinator {
    func runMainFlow() {
        var dreamsCoordinator = coordinatorsFactory.makeDreamsListCoordinator()
        dreamsCoordinator.start()
        addDependency(dreamsCoordinator)
        dreamsCoordinator.finishFlow = { [weak self] in
            self?.removeDependency(dreamsCoordinator)
        }
    }
}
