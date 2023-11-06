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

    init(
        store: Store<AppState>,
        dreamListThunkFactory: DreamListThunkFactory
    ) {
        self.store = store
        self.dreamListThunkFactory = dreamListThunkFactory
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
