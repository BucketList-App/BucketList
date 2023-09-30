import Factory
import ReSwift
import State
import Core

extension Container {
    var store: Factory<Store<AppState>> {
        self { Store<AppState>(reducer: appReducer, state: nil) }
            .singleton
    }

    var dreamsCoordinator: Factory<Coordinator> {
        self { DreamsCoordinator() }
            .unique
    }
}
