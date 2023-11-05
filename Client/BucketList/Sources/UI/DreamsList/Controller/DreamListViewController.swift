import UIKit
import State
import Core
import ReSwift
import CoreUI
import Models

class DreamListViewController: UIViewController {

    var openDream: ((Dream) -> Void)?

    private let store: Store<AppState>
    private let dreamListThunkFactory: DreamListThunkFactory

    init(
        store: Store<AppState>,
        dreamListThunkFactory: DreamListThunkFactory
    ) {
        self.store = store
        self.dreamListThunkFactory = dreamListThunkFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let collectionView = makeCollectionView()

    private var dreams: [Dream] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        store.subscribe(self) { subscription in
            subscription.select(\.dreamsListState)
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
            withReuseIdentifier: DreamListViewCell.reuseIdentifier,
            for: indexPath
        ) as? DreamListViewCell else { return UICollectionViewCell() }
        let dream = dreams[indexPath.item]
        cell.configure(with: dream)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let dream = dreams[indexPath.item]
        openDream?(dream)
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
    func newState(state: DreamsListState) {
        dreams = state.dreams
    }
}

private extension DreamListViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(
            DreamListViewCell.self,
            forCellWithReuseIdentifier: DreamListViewCell.reuseIdentifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    static func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constants.sectionInset

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorPalette.DreamsList.background
        return collectionView
    }
}

private extension DreamListViewController {
    enum Constants {
        static let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
