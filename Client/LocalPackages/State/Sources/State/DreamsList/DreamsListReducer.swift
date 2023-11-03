import ReSwift

public func dreamsListReducer(action: Action, state: DreamsListState?) -> DreamsListState {
    var state = state ?? DreamsListState()

    switch action {
    case let DreamsListAction.update(dreams):
        state.dreams = dreams
    default:
        break
    }

    return state
}
