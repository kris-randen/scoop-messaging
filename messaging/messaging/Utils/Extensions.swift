//
//  Extensions.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation
import UIKit

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
