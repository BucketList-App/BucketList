import CoreUI
import Models
import SnapKit
import UIKit

class DreamListViewCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        label.numberOfLines = 2
        label.text = "sfsdfsdfsdfs"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorPalette.DreamsList.snippet
        setupShadowAndCornerRadius()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    func configure(with dream: Dream) {
        titleLabel.text = dream.title
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
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        imageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(Constants.inset)
            make.trailing.equalTo(contentView).inset(Constants.inset)
            make.bottom.equalTo(titleLabel.snp.top).inset(-Constants.inset)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.inset)
            make.bottom.equalTo(contentView).inset(Constants.inset)
        }
    }
}

private extension DreamListViewCell {
    enum Constants {
        static let inset = 10
        static let cornerRadius = 20.0
    }
}
