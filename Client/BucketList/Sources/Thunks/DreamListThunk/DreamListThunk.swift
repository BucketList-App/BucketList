import State
import ReSwift

enum DreamListThunk {

    static func dreamsListInitialize(dreamsProvider: DreamsProvider) -> Thunk<AppState> {
        Thunk<AppState> { dispatch, _ in
            let dreams = dreamsProvider.provide()
            dispatch(DreamsListAction.update(dreams: dreams))
        }
    }
}
