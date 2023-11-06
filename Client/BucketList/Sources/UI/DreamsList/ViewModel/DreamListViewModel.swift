//
//  DreamListViewModel.swift
//  BucketList
//
//  Created by Gleb Fandeev on 05.11.2023.
//

import DifferenceKit
import Foundation
import Models
import ReSwift
import State

final class DreamListViewModel {

    var isEditingMode = false

    private var dreams: [Dream] = []

    private let store: Store<AppState>
    private let dreamListThunkFactory: DreamListThunkFactory
    private let sizeCaching: DreamListItemSizeSessionCaching

    init(
        store: Store<AppState>,
        dreamListThunkFactory: DreamListThunkFactory,
        sizeCaching: DreamListItemSizeSessionCaching
    ) {
        self.store = store
        self.dreamListThunkFactory = dreamListThunkFactory
        self.sizeCaching = sizeCaching
    }

    func update(with dreams: [Dream]) {
        self.dreams = dreams
    }

    func add(dream: Dream) {
        dreams.append(dream)
        store.dispatch(DreamsListAction.update(dreams: dreams))
    }

    func stagedChangeset(target: [Dream]) -> StagedChangeset<[Dream]> {
        StagedChangeset(source: dreams, target: target)
    }

    // Поддержать sync стейта и данных в провайдере (в middleware ?) для drag and drop
    func moveItem(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dream = dreams.remove(at: sourceIndexPath.item)
        dreams.insert(dream, at: destinationIndexPath.item)
        store.dispatch(DreamsListAction.update(dreams: dreams))
    }

    // Предусмотреть вариант запуска приложения уже их landscape режима. В таком случае
    // можно заранее закешировать дефолты или вообще можно рассмотреть константные значения ячейки
    func intercept(size: CGSize) -> CGSize {
        if let cachedSize = sizeCaching.getSize(for: .portrait) {
            return cachedSize
        } else {
            sizeCaching.cache(size)
            return size
        }
    }

    func fetchDreams() {
        store.dispatch(dreamListThunkFactory.makeDreamsListInitialize())
    }

}

// MARK: UICollectionViewDataSource providing

extension DreamListViewModel {

    func numberOfItems(in section: Int) -> Int {
        dreams.count
    }

    func dream(for indexPath: IndexPath) -> Dream {
        dreams[indexPath.item]
    }

}
