//
//  DreamListItemSizeSessionCaching.swift
//  BucketList
//
//  Created by Gleb Fandeev on 06.11.2023.
//

import UIKit

final class DreamListItemSizeSessionCaching {

    private var cache: [UIDeviceOrientation: CGSize] = [:]

    static let shared = DreamListItemSizeSessionCaching()

    private init() {}

    @inlinable
    func cache(_ size: CGSize) {
        cache[UIDevice.current.orientation] = size
    }

    @inlinable
    func getSize(for orientation: UIDeviceOrientation) -> CGSize? {
        cache[orientation]
    }

}
