//
//  Dimensions.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import UIKit

struct Dimensions {
    static let Bounds: CGRect = UIScreen().bounds
    static let Height: CGFloat = Bounds.height
    static let Width: CGFloat = Bounds.width
    static let MinDim: CGFloat = Bounds.minDim
    
    struct HeightScaling {
        static let textField: CGFloat = 25
        static let button: CGFloat = 17
        static let scoopLogoLarge: CGFloat = 20.0
    }
    
    struct WidthScaling {
        static let fullWidth: CGFloat = 1.2
        static let halfWidth: CGFloat = 2.3
        static let fullWidthPadding: CGFloat = 19.5
        static let halfButtonPadding: CGFloat = 100
    }
    
    struct CornerRadiusScaling {
        static let textField: CGFloat = 32.0
        static let picker: CGFloat = 5.0
        
    }
    
    enum Scaling {
        case width(factor: CGFloat, dimension: CGFloat = Width)
        case height(factor: CGFloat, dimension: CGFloat = Height)
        case corner(factor: CGFloat, dimension: CGFloat = MinDim)
        case padding(factor: CGFloat, dimension: CGFloat = MinDim)
        
        var value: CGFloat {
            switch self {
            case .width(let factor, let dimension),
                 .height(let factor, let dimension),
                 .corner(let factor, let dimension),
                 .padding(let factor, let dimension):
                return dimension / factor
            }
        }
    }
}
