import UIKit

public protocol Coordinator {
    var presentingController: UINavigationController? { get set }
    func start()
}
