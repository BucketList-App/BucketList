import Core

final class CoordinatorsFactory {

    private let router: Router

    init(router: Router) {
        self.router = router
    }

    func makeDreamsListCoordinator() -> Coordinator {
        DreamsListCoordinator(
            router: router,
            coordinatorsFactory: self,
            dreamListThunkFactory: ThunkContainer.shared.dreamListThunkFactory.resolve()
        )
    }

    func makeDreamInfoCoordinator() -> Coordinator {
        DreamInfoCoordinator(router: router)
    }

}
