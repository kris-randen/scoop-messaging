//
//  RoundedLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import Foundation

struct RoundedRect: RoundedRectProperties {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
    let radiusScaling: CGFloat
    var orientation: CGRect.Orientation = .horizontal
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, radiusScaling: CGFloat, orientation: CGRect.Orientation = .horizontal) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.radiusScaling = radiusScaling
        self.orientation = orientation
    }
    
    init(rect: CGRect, radiusScaling: CGFloat, orientation: CGRect.Orientation = .horizontal) {
        self.x = rect.origin.x
        self.y = rect.origin.y
        self.width = rect.width
        self.height = rect.height
        self.radiusScaling = radiusScaling
        self.orientation = orientation
    }
}
