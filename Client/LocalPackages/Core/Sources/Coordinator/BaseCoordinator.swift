open class BaseCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    public init() {}

    open func start() {}

    public func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { coordinator === $0 }) else { return }
        childCoordinators.append(coordinator)
    }

    public func removeDependency(_ coordinator: Coordinator?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
        else { return }

        childCoordinators = childCoordinators.filter { coordinator !== $0 }
    }
}
