import Factory

final class ThunkContainer: SharedContainer {

    static let shared = ThunkContainer()
    let manager = ContainerManager()

    var dreamListThunkFactory: Factory<DreamListThunkFactory> {
        self {
            DreamListThunkFactory(
                dreamsProvider: ServiceContainer.shared.dreamsProvider.resolve()
            )
        }.singleton
    }
}
