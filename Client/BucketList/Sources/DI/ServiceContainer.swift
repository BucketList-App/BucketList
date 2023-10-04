import Factory

final class ServiceContainer: SharedContainer {

    static let shared = ServiceContainer()
    let manager = ContainerManager()

    var dreamsProvider: Factory<DreamsProvider> {
        self { DreamsProvider() }
            .singleton
    }
}
