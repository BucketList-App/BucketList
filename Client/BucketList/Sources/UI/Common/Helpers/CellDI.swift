//
//  CellDI.swift
//  BucketList
//
//  Created by Gleb Fandeev on 06.11.2023.
//

import ReSwift
import State

final class CellDI {

    private let store: Store<AppState>
    private let dreamListThunkFactory: DreamListThunkFactory

    init(store: Store<AppState>, dreamListThunkFactory: DreamListThunkFactory) {
        self.store = store
        self.dreamListThunkFactory = dreamListThunkFactory
    }

    func inject(_ cell: DreamListViewCell) {
        cell.inject(store: store, dreamListThunkFactory: dreamListThunkFactory)
    }
}
