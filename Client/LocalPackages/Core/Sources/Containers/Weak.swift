public struct Weak<T: AnyObject> {

    public private(set) weak var value: T?

    public init(value: T?) {
        self.value = value
    }
}
