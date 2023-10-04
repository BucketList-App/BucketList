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

    var appCoordinator: Factory<Coordinator> {
        self {
            AppCoordinator(
                router: self.appRouter.resolve(),
                coordinatorsFactory: self.coordinatorsFactory.resolve()
            )
        }.singleton
    }

    var appRouter: Factory<Router> {
        self { AppRouter(navigationController: nil) }
            .singleton
    }

    var coordinatorsFactory: Factory<CoordinatorsFactory> {
        self { CoordinatorsFactory(router: self.appRouter.resolve()) }
            .singleton
    }    
}
