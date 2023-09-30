import UIKit
import SnapKit

class DreamCollectionViewCell: UICollectionViewCell {

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
        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true

        makeConstraints()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DreamCollectionViewCell {
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

private extension DreamCollectionViewCell {
    enum Constants {
        static let inset = 10
        static let cornerRadius = 20.0
    }
}