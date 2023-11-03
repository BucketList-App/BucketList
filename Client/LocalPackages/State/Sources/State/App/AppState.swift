import ReSwift

public class AppState: Equatable {

    public var dreamsListState: DreamsListState
    public var dreamInfoState: DreamInfoState

    public init (
        dreamsListState: DreamsListState,
        dreamInfoState: DreamInfoState
    ) {
        self.dreamsListState = dreamsListState
        self.dreamInfoState = dreamInfoState
    }

    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.dreamsListState == rhs.dreamsListState &&
        lhs.dreamInfoState == rhs.dreamInfoState
    }
}
