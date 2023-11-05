//
//  AppAssembler.swift
//  BucketList
//
//  Created by Gleb Fandeev on 05.11.2023.
//

import Core
import ReSwift
import State

final class AppAssembler {

    // MARK: Properties

    private lazy var store = Store<AppState>(
        reducer: appReducer,
        state: nil,
        middleware: [
            // keep last
            createThunkMiddleware()
        ]

    )

    private lazy var appRouter = AppRouter(navigationController: nil)
    private lazy var appCoordinator = AppCoordinator(
        router: appRouter,
        coordinatorsFactory: coordinatorsFactory
    )

    private lazy var coordinatorsFactory = CoordinatorsFactory(
        strore: store,
        router: appRouter,
        dreamListThunkFactory: dreamListThunkFactory
    )
    private lazy var dreamListThunkFactory = DreamListThunkFactory(
        dreamsProvider: DreamsProvider()
    )

    // MARK: Public

    func makeAppCoordinator() -> Coordinator {
        appCoordinator
    }

    func makeAppRouter() -> Router {
        appRouter
    }

}
