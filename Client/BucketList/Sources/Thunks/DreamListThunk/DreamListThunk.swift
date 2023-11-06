import Models
import ReSwift
import State

enum DreamListThunk {

    static func dreamsListInitialize(dreamsProvider: DreamsProvider) -> Thunk<AppState> {
        Thunk<AppState> { dispatch, _ in
            let dreams = dreamsProvider.provide()
            dispatch(DreamsListAction.update(dreams: dreams))
        }
    }

    static func deleteDream(_ dream: Dream, dreamsProvider: DreamsProvider) -> Thunk<AppState> {
        Thunk<AppState> { [dreamsProvider] dispatch, getState in
            guard let dreams = getState()?.dreamsListState.dreams else { return }

            let stateFilteredDreams = dreams.filter { $0 != dream }
            let filteredDreams = dreamsProvider.provide().filter { $0 != dream }

            if stateFilteredDreams != filteredDreams {
                return assertionFailure("Dreams from state and provider must be equal")
            }
            dreamsProvider.update(stateFilteredDreams)

            dispatch(DreamsListAction.update(dreams: filteredDreams))
        }
    }
}
