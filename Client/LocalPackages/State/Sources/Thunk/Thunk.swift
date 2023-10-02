import ReSwift

public struct Thunk<State>: Action {

    public typealias Body = (
        _ dispatch: @escaping DispatchFunction,
        _ getState: @escaping () -> State?
    ) -> Void

    let body: Body

    public init(body: @escaping Body) {
        self.body = body
    }
}
