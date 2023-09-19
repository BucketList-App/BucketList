//
//  ViewController.swift
//  MyApp
//
//  Created by Gleb Fandeev on 05.09.2023.
//

import UIKit

// Модель данных для мечты
struct Dream {
    var title: String
    var imageName: String
}

class DreamCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DreamListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    let dreams: [Dream] = [
        Dream(title: "Мечта 1", imageName: "heart.fill"),
        Dream(title: "Мечта 2", imageName: "dream2"),
        Dream(title: "Мечта 3", imageName: "dream2"),
        Dream(title: "Мечта 4", imageName: "dream2"),
        Dream(title: "Мечта 5", imageName: "heart.fill"),
        Dream(title: "Мечта 6", imageName: "dream2"),
        Dream(title: "Мечта 7", imageName: "dream2"),
        Dream(title: "Мечта 8", imageName: "dream2"),
        Dream(title: "Мечта 9", imageName: "dream2"),
        Dream(title: "Мечта 10", imageName: "dream2")

    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.register(DreamCollectionViewCell.self, forCellWithReuseIdentifier: "DreamCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dreams.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DreamCell",
            for: indexPath
        ) as? DreamCollectionViewCell else { return UICollectionViewCell() }
        let dream = dreams[indexPath.item]
        cell.imageView.image = UIImage(systemName: dream.imageName)
        cell.titleLabel.text = dream.title
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10) / 2
        let cellHeight: CGFloat = (collectionView.frame.height - 40) / 4
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
