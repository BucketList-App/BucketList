import UIKit
import State
import Core
import ReSwift
import Factory
import CoreUI

class DreamListViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constants.sectionInset

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorPalette.DreamsList.background
        return collectionView
    }()

    @Injected(\.store) private var store: Store<AppState>

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.register(DreamCollectionViewCell.self, forCellWithReuseIdentifier: "DreamCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }

}

// MARK: UICollectionViewDataSource

extension DreamListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DreamCell",
            for: indexPath
        ) as? DreamCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension DreamListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let horizontalSpacing = 2 * (Constants.sectionInset.left + Constants.sectionInset.right)
        let cellWidth = (collectionView.frame.width - horizontalSpacing) / 2

        let verticalSpacing = 3 * (Constants.sectionInset.top + Constants.sectionInset.bottom)
        let cellHeight = (collectionView.frame.height - verticalSpacing - 60) / 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

private extension DreamListViewController {
    enum Constants {
        static let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
