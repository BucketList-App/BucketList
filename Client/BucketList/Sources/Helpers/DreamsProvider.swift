import Models

final class DreamsProvider {

    private var dreams: [Dream]

    init() {
        dreams = [
            .init(title: "See the Eiffel Tower"),
            .init(title: "Jump from a parachute"),
            .init(title: "Attend a Music Festival"),
            .init(title: "Get a Tattoo"),
            .init(title: "Fly in a Helicopter"),
            .init(title: "Learn Spanish"),
            .init(title: "Buy iPhone 15")
        ]
    }

    init(dreams: [Dream]) {
        self.dreams = dreams
    }

    func provide() -> [Dream] {
        dreams
    }

    func update(_ dreams: [Dream]) {
        self.dreams = dreams
    }

}
