import Models
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

    func makeDeleteDream(dream: Dream) -> Thunk<AppState> {
        DreamListThunk.deleteDream(dream, dreamsProvider: dreamsProvider)
    }

}
