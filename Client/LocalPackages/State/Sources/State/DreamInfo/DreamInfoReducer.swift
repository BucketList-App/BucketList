import ReSwift

public func dreamInfoReducer(action: Action, state: DreamInfoState?) -> DreamInfoState {
    var state = state ?? DreamInfoState()

    switch action {
    case let DreamInfoAction.update(dream):
        state.dream = dream
    default:
        break
    }

    return state
}
