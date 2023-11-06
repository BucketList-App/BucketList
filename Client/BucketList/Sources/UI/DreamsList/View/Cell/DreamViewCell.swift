import Core
import CoreUI
import Models
import ReSwift
import SnapKit
import State
import UIKit

class DreamListViewCell: UICollectionViewCell {

    private lazy var imageView = makeImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var deleteButton = makeDeleteButton()

    private var store: Store<AppState>?
    private var dreamListThunkFactory: DreamListThunkFactory?

    private var dream: Dream? {
        didSet {
            titleLabel.text = dream?.title ?? ""
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorPalette.DreamsList.Snippet.background
        setupShadowAndCornerRadius()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    func configure(with dream: Dream) {
        self.dream = dream
    }

    func inject(
        store: Store<AppState>,
        dreamListThunkFactory: DreamListThunkFactory
    ) {
        guard self.store == nil, self.dreamListThunkFactory == nil else { return }

        self.store = store
        self.dreamListThunkFactory = dreamListThunkFactory
    }

    func startEditingMode() {
        startShakeAnimation()
        showDeleteButton()
    }

    func stopEditingMode() {
        stopShakeAnimation()
        hideDeleteButton()
    }

    private func startShakeAnimation() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = .infinity
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = -0.01
        shakeAnimation.toValue = 0.01
        layer.add(shakeAnimation, forKey: Constants.shakeAnimationKey)
    }

    private func stopShakeAnimation() {
        layer.removeAnimation(forKey: Constants.shakeAnimationKey)
    }

    private func showDeleteButton() {
        deleteButton.isHidden = false
        deleteButton.isEnabled = true
    }

    private func hideDeleteButton() {
        deleteButton.isHidden = true
        deleteButton.isEnabled = false
    }

}

private extension DreamListViewCell {
    func setupShadowAndCornerRadius() {
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true

        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = false

        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: Constants.cornerRadius
        ).cgPath
    }

    func makeConstraints() {
        addSubviews(imageView, titleLabel, deleteButton)

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self).inset(Constants.inset)
            make.height.equalTo(imageView.snp.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(-Constants.inset)
            make.leading.trailing.equalTo(self).inset(Constants.inset)
            make.bottom.equalTo(self).inset(Constants.inset)
        }

        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.top).inset(Constants.inset)
            make.centerX.equalTo(self.snp.trailing).inset(Constants.inset)
            make.width.height.equalTo(Constants.deleteButtonSize)
        }
    }
}

private extension DreamListViewCell {
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        label.numberOfLines = 2
        return label
    }

    func makeDeleteButton() -> UIButton {
        let button = UIButton()
        button.setImage(
            Icons.trash,
            for: .normal
        )
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        button.layer.cornerRadius = Constants.deleteButtonSize / 2
        button.layer.borderWidth = 0.5
        button.layer.borderColor = ColorPalette.DreamsList.Snippet.deleteBorder.cgColor
        button.backgroundColor = ColorPalette.DreamsList.Snippet.deleteBackground

        button.isHidden = true
        button.isEnabled = false

        return button
    }

    @objc func deleteButtonTapped() {
        guard let dream, let store, let dreamListThunkFactory else {
            return assertionFailure("DreamListViewCell: dependencies must not be nil")
        }
        store.dispatch(dreamListThunkFactory.makeDeleteDream(dream: dream))
    }
}

private extension DreamListViewCell {
    enum Constants {
        static let inset = 10
        static let cornerRadius = 20.0
        static let shakeAnimationKey = "shakeAnimation"
        static let deleteButtonSize = 40.0
    }
}
