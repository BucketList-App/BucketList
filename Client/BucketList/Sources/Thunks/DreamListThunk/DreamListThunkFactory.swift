import ReSwift
import State

struct DreamListThunkFactory {

    private let dreamsProvider: DreamsProvider

    init(dreamsProvider: DreamsProvider) {
        self.dreamsProvider = dreamsProvider
    }

    func makeDreamsListInitialize() -> Thunk<AppState> {
        DreamListThunk.dreamsListInitialize(dreamsProvider: dreamsProvider)
    }

}
