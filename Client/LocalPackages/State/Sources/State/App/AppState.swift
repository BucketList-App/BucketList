import ReSwift

public class AppState: Equatable {

    public var dreamsState: DreamsState

    public init (dreamsState: DreamsState) {
        self.dreamsState = dreamsState
    }

    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.dreamsState == rhs.dreamsState
    }
}
