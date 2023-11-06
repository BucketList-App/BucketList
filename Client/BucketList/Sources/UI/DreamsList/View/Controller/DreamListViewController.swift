import Core
import CoreUI
import DifferenceKit
import Models
import ReSwift
import State
import UIKit

class DreamListViewController: UIViewController {

    var openDream: ((Dream) -> Void)?

    private lazy var collectionView = makeCollectionView()
    private lazy var refreshControl = UIRefreshControl()

    private let store: Store<AppState>
    private let viewModel: DreamListViewModel
    private let cellDI: CellDI

    init(
        store: Store<AppState>,
        viewModel: DreamListViewModel,
        cellDI: CellDI
    ) {
        self.store = store
        self.viewModel = viewModel
        self.cellDI = cellDI
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupRefreshControl()
        setupBasicNavigationBar()

        store.subscribe(self) { subscription in
            subscription.select(\.dreamsListState)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchDreams()
    }

}

// MARK: StoreSubscriber

extension DreamListViewController: StoreSubscriber {
    func newState(state: DreamsListState) {
        let changeset = viewModel.stagedChangeset(target: state.dreams)
        DispatchQueue.main.async {
            self.collectionView.reload(using: changeset) { data in
                self.viewModel.update(with: data)
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension DreamListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DreamListViewCell.reuseIdentifier,
            for: indexPath
        ) as? DreamListViewCell else { return UICollectionViewCell() }

        cellDI.inject(cell)
        let dream = viewModel.dream(for: indexPath)
        cell.configure(with: dream)

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard !viewModel.isEditingMode else { return }

        let dream = viewModel.dream(for: indexPath)
        openDream?(dream)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension DreamListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard viewModel.isEditingMode, let cell = cell as? DreamListViewCell else { return }
        cell.startEditingMode()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard viewModel.isEditingMode, let cell = cell as? DreamListViewCell else { return }
        cell.stopEditingMode()
    }

    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return viewModel.isEditingMode
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let horizontalSpacing = 2 * (Constants.sectionInset.left + Constants.sectionInset.right)
        let cellWidth = (collectionView.frame.width - horizontalSpacing) / 2

        let verticalSpacing = 3 * (Constants.sectionInset.top + Constants.sectionInset.bottom)
        let additionalHeight = 60.0
        let cellHeight = (collectionView.frame.height - verticalSpacing - additionalHeight) / 3

        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: CollectionView + Refresher setup

private extension DreamListViewController {

    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constants.sectionInset

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = ColorPalette.DreamsList.background

        return collectionView
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(
            DreamListViewCell.self,
            forCellWithReuseIdentifier: DreamListViewCell.reuseIdentifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }

    @objc func didPullToRefresh() {
        viewModel.fetchDreams()
        refreshControl.endRefreshing()
    }
}

// MARK: NavigationBar + Actions

private extension DreamListViewController {

    func setupBasicNavigationBar() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = editButton
    }

    func setupEditNavigationBar() {
        let saveButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
    }

    @objc func addButtonTapped() {
        // TBD
    }

    @objc func editButtonTapped() {
        viewModel.isEditingMode.toggle()
        setupEditNavigationBar()
        onDreamsVisibleCells { cells in
            cells.forEach { $0.startEditingMode() }
        }
    }

    @objc func saveButtonTapped() {
        viewModel.isEditingMode.toggle()
        setupBasicNavigationBar()
        onDreamsVisibleCells { cells in
            cells.forEach { $0.stopEditingMode() }
        }
    }

    @objc func cancelButtonTapped() {
        // Можно изменять UI, но по кнопке отмены, все изменения откатывать до предыдущего
        // состояния с анимацией и обновлять стейт из провайдера, а по кнопке сохранить -
        // синкать состояние провайдера/менеджера и стейта. Сделаю попозже
    }

    func onDreamsVisibleCells(block: (([DreamListViewCell]) -> Void)) {
        let visibleCells = collectionView.visibleCells.compactMap { $0 as? DreamListViewCell }
        block(visibleCells)
    }
}

// MARK: Constants

private extension DreamListViewController {
    enum Constants {
        static let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
