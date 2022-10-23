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
    func offset(to p: CGPoint) -> CGPoint {
        CGPoint(x: self.x + p.x, y: self.y + p.y)
    }
    
    static prefix func - (p: CGPoint) -> CGPoint {
        return CGPoint(x: -p.x, y: -p.y)
    }
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
