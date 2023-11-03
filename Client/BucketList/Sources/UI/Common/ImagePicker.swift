import UIKit
import Core

final class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let router: Router
    private var completion: ((Result<UIImage, Error>) -> Void)?
    private lazy var imagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()

    init(router: Router) {
        self.router = router
    }

    func showPickImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
        self.completion = completion
        router.present(imagePickerController)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            completion?(.success(image))
        } else {
            completion?(.failure(NSError()))
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}
