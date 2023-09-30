import UIKit

public protocol Coordinator {
    var presentingController: UIViewController? { get set }
    func start()
}
