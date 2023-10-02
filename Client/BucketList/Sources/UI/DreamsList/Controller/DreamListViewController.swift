import UIKit
import State
import Core
import ReSwift
import Factory
import CoreUI
import Models

class DreamListViewController: UIViewController {

    var openDream: (() -> Void)?

    @Injected(\.store) private var store: Store<AppState>
    @Injected(\.dreamListThunkFactory) private var dreamListThunkFactory: DreamListThunkFactory

    private var dreams: [Dream] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constants.sectionInset

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorPalette.DreamsList.background
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        store.subscribe(self) { subscription in
            subscription.select(\.dreamsState)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.dispatch(dreamListThunkFactory.makeDreamsListInitialize())
    }

}

// MARK: UICollectionViewDataSource

extension DreamListViewController: UICollectionViewDataSource {

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
        cell.configure(with: dream)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        openDream?()
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
        let cellHeight = (collectionView.frame.height - verticalSpacing - 120) / 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension DreamListViewController: StoreSubscriber {
    func newState(state: DreamsState) {
        dreams = state.dreams
    }
}

private extension DreamListViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(DreamCollectionViewCell.self, forCellWithReuseIdentifier: "DreamCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private extension DreamListViewController {
    enum Constants {
        static let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
