import ReSwift

public func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(dreamsState: dreamsReducer(action: action, state: state?.dreamsState))
}
