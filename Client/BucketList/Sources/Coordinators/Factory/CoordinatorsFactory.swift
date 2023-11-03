import Core
import Models

final class CoordinatorsFactory {

    private let router: Router

    init(router: Router) {
        self.router = router
    }

    func makeDreamsListCoordinator() -> Coordinator & DreamsListCoordinatorOutput {
        DreamsListCoordinator(
            router: router,
            coordinatorsFactory: self,
            dreamListThunkFactory: ThunkContainer.shared.dreamListThunkFactory.resolve()
        )
    }

    func makeDreamInfoCoordinator(dream: Dream) -> Coordinator & DreamInfoCoordinatorOutput {
        DreamInfoCoordinator(router: router, dream: dream)
    }

}
