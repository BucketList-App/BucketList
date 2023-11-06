//
//  Dream+Diff.swift
//  BucketList
//
//  Created by Gleb Fandeev on 06.11.2023.
//

import DifferenceKit
import Models

extension Dream: Differentiable {

    public var differenceIdentifier: String {
        return id
    }

    public func isContentEqual(to source: Self) -> Bool {
        return self == source
    }
}
