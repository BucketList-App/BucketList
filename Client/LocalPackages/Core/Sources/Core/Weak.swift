public struct Weak<T: AnyObject> {

    private(set) public weak var value: T?

    public init(value: T?) {
        self.value = value
    }
}
