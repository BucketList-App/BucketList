import Core
import Models
import ReSwift
import State

final class CoordinatorsFactory {

    private let strore: Store<AppState>
    private let router: Router
    private let dreamListThunkFactory: DreamListThunkFactory

    init(
        strore: Store<AppState>,
        router: Router,
        dreamListThunkFactory: DreamListThunkFactory
    ) {
        self.strore = strore
        self.router = router
        self.dreamListThunkFactory = dreamListThunkFactory
    }

    func makeDreamsListCoordinator() -> Coordinator & DreamsListCoordinatorOutput {
        DreamsListCoordinator(
            store: strore,
            router: router,
            coordinatorsFactory: self,
            dreamListThunkFactory: dreamListThunkFactory
        )
    }

    func makeDreamInfoCoordinator(dream: Dream) -> Coordinator & DreamInfoCoordinatorOutput {
        DreamInfoCoordinator(
            store: strore,
            router: router,
            dream: dream
        )
    }

}
