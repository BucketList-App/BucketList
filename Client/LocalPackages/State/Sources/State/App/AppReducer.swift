import ReSwift

public func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(
        dreamsListState: dreamsListReducer(action: action, state: state?.dreamsListState),
        dreamInfoState: dreamInfoReducer(action: action, state: state?.dreamInfoState)
    )
}
