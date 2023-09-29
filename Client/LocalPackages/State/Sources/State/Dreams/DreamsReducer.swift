import ReSwift

public func dreamsReducer(action: Action, state: DreamsState?) -> DreamsState {
    var state = state ?? DreamsState()

    switch action {
    case let DreamsAction.update(dreams):
        state.dreams = dreams
    default:
        break
    }

    return state
}
