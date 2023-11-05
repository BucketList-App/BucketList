import UIKit
import State
import ReSwift
import Models
import CoreUI

final class DreamInfoViewController: UIViewController {

    var finishFlow: (() -> Void)?

    private var dream: Dream

    private let store: Store<AppState>
    private let imagePicker: ImagePicker

    private let titleTextView = DreamInfoComponentsFactory.makeTitleTextView()
    private let imageView = DreamInfoComponentsFactory.makeImageView()
    private let descriptionTextView = DreamInfoComponentsFactory.makeDescriptionTextView()

    init(
        store: Store<AppState>,
        dream: Dream,
        imagePicker: ImagePicker
    ) {
        self.store = store
        self.dream = dream
        self.imagePicker = imagePicker

        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .lightestGray

        store.subscribe(self) { subscription in
            subscription.select(\.dreamInfoState)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        finishFlow?()
    }

}

extension DreamInfoViewController: StoreSubscriber {
    func newState(state: DreamInfoState) {

    }
}

private extension DreamInfoViewController {
    func setupLayout() {
        view.addSubviews(titleTextView, imageView, descriptionTextView)

        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.spacing)
            make.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            make.height.equalTo(titleTextView.height(forNumberOfLines: 2))
        }
        setupImageView()
    }

    func setupImageView() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).inset(-Constants.spacing)
            make.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            make.height.equalTo(300)
        }

        if imageView.image == nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(showImagePicher))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
            imageView.image = UIImage(systemName: "plus")
        }
    }

    @objc private func showImagePicher() {
        imagePicker.showPickImage { result in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case .failure:
                print("failure")
            }
        }
    }
}

private extension DreamInfoViewController {
    enum Constants {
        static let spacing = 10.0
    }
}
