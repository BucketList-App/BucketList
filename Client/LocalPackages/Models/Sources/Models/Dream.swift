import UIKit

public struct Dream: Equatable {

    public let id: String
    public let title: String
    public let description: String?
    public let image: UIImage?
    public let deadline: Date?
    public let isCompleted: Bool

    public init(
        id: String = UUID().uuidString,
        title: String,
        description: String? = nil,
        image: UIImage? = nil,
        deadline: Date? = nil,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.deadline = deadline
        self.isCompleted = isCompleted
    }
}
