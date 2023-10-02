import Factory
import ReSwift
import State
import Core

extension Container {
    var store: Factory<Store<AppState>> {
        self {
            Store<AppState>(
                reducer: appReducer,
                state: nil,
                middleware: [
                    // keep last
                    createThunkMiddleware()
                ]
            )
        }.singleton
    }

    var dreamsCoordinator: Factory<Coordinator> {
        self { DreamsCoordinator() }
            .unique
    }

    var dreamsProvider: Factory<DreamsProvider> {
        self { DreamsProvider() }
            .singleton
    }

    var dreamListThunkFactory: Factory<DreamListThunkFactory> {
        self { DreamListThunkFactory(dreamsProvider: self.dreamsProvider.resolve()) }
            .singleton
    }
}
