//
//  Extensions.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation
import UIKit


extension Int {
    var double: Double { Double(self) }
    
    var degrees: Angle { Angle(degrees: Double(self)) }
}

extension Double {
    var int: Int { Int(self) }
    
    var degrees: Angle { Angle(degrees: self) }
}

extension CGPoint {
    static var zero: CGPoint { CGPoint(x: 0, y: 0) }
    
    func offset(to p: CGPoint) -> CGPoint {
        CGPoint(x: self.x + p.x, y: self.y + p.y)
    }
    
    static prefix func - (p: CGPoint) -> CGPoint {
        return CGPoint(x: -p.x, y: -p.y)
    }
}

extension CGRect {
    enum Orientation {
        case vertical
        case horizontal
    }
    
    var originLocal: CGPoint { CGPoint.zero }
    var originGlobal: CGPoint { origin }
    
    var topLeft: CGPoint { CGPoint.zero }
    var topRight: CGPoint { CGPoint(x: width, y: 0) }
    var bottomLeft: CGPoint { CGPoint(x: 0, y: height) }
    var bottomRight: CGPoint { CGPoint(x: width, y: height) }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { topLeft.offset(to: originGlobal) }
    var topRightGlobal: CGPoint { topRight.offset(to: originGlobal) }
    var bottomLeftGlobal: CGPoint { bottomLeft.offset(to: originGlobal) }
    var bottomRightGlobal: CGPoint { bottomRight.offset(to: originGlobal) }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
    
    var orientation: Orientation {
        return height > width ? .vertical : .horizontal
    }
}

extension Path {
    
}

extension GeometryProxy {
    var bounds: CGRect { frame(in: .local) }
    var origin: CGPoint { bounds.origin }
    
    var minX: CGFloat { bounds.minX }
    var minY: CGFloat { bounds.minY }
    var midX: CGFloat { bounds.midX }
    var midY: CGFloat { bounds.midY }
    var maxX: CGFloat { bounds.maxX }
    var maxY: CGFloat { bounds.maxY }
    
    var height: CGFloat { size.height }
    var width: CGFloat { size.width }
    var minDim: CGFloat { bounds.minDim }
    
    var boundsGlobal: CGRect { frame(in: .global) }
    var originGlobal: CGPoint { boundsGlobal.origin }
    
    var minXGlobal: CGFloat { boundsGlobal.minX }
    var minYGlobal: CGFloat { boundsGlobal.minY }
    var midXGlobal: CGFloat { boundsGlobal.midX }
    var midYGlobal: CGFloat { boundsGlobal.midY }
    var maxXGlobal: CGFloat { boundsGlobal.maxX }
    var maxYGlobal: CGFloat { boundsGlobal.maxY }
    
    
    var topLeft: CGPoint { bounds.topLeft }
    var topRight: CGPoint { bounds.topRight }
    var bottomLeft: CGPoint { bounds.bottomLeft }
    var bottomRight: CGPoint { bounds.bottomRight }
    
    var center: CGPoint { CGPoint(x: width / 2, y: height / 2) }
    var topCenter: CGPoint { CGPoint(x: width / 2, y: 0) }
    var bottomCenter: CGPoint { CGPoint(x: width / 2, y: height)}
    var leftCenter: CGPoint { CGPoint(x: 0, y: height / 2) }
    var rightCenter: CGPoint { CGPoint(x: width, y: height / 2) }
    
    var topLeftGlobal: CGPoint { boundsGlobal.topLeftGlobal }
    var topRightGlobal: CGPoint { boundsGlobal.topRightGlobal }
    var bottomLeftGlobal: CGPoint { boundsGlobal.bottomLeftGlobal }
    var bottomRightGlobal: CGPoint { boundsGlobal.bottomRightGlobal }
    
    var centerGlobal: CGPoint { center.offset(to: originGlobal) }
    var topCenterGlobal: CGPoint { topCenter.offset(to: originGlobal) }
    var bottomCenterGlobal: CGPoint { bottomCenter.offset(to: originGlobal) }
    var leftCenterGlobal: CGPoint { leftCenter.offset(to: originGlobal) }
    var rightCenterGlobal: CGPoint { rightCenter.offset(to: originGlobal) }
}

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint { lhs.offset(to: rhs) }
func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint { lhs.offset(to: -rhs) }
func *(lhs: Double, rhs: CGPoint) -> CGPoint { CGPoint(x: lhs*rhs.x, y: lhs*rhs.y) }

extension View {
    var screen: CGRect {
        UIScreen.main.bounds
    }
    var screenWidth: CGFloat {
        screen.width
    }
    var screenHeight: CGFloat {
        screen.height
    }
}

extension CGRect {
    var minDim: CGFloat {
        min(width, height)
    }
}

//#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//#endif

extension String {
    func doesContain(_ other: String) -> Bool {
        other.isEmpty || self.contains(other)
    }
}
