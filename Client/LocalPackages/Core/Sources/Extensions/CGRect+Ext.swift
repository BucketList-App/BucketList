//
//  CGRect+Ext.swift
//  
//
//  Created by Gleb Fandeev on 06.11.2023.
//

import Foundation

public extension CGRect {

    /** Creates a rectangle with the given center and dimensions
     - parameter center: The center of the new rectangle
     - parameter size: The dimensions of the new rectangle
    */
    init(center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2),
            size: size
        )
    }

    /**
     the coordinates of this rectangles center
    */
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
