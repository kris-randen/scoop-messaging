//
//  Fonts.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import UIKit
import SwiftUI

struct Fonts {
    static let scoopLogoSignIn = Font.custom("Avenir", size: 28, relativeTo: .largeTitle).weight(.black)
    static let signInTextField = Font.custom("Avenir", size: 16, relativeTo: .caption).weight(.light)
    static let fullWidthButtonLabel = Font.custom("Avenir", size: 20, relativeTo: .title2).weight(.black)
    static let halfWidthButtonLabel = Font.custom("Avenir", size: 14, relativeTo: .caption).weight(.medium)
    static let signInTextFieldIcon = Font.custom("Avenir Next", size: 21, relativeTo: .caption).weight(.thin)
    static let signInScreenSmall = Font.custom("Avenir Next", size: 14, relativeTo: .caption).weight(.medium)
    static let googleButtonIconFont = Font.custom("Georgia", size: 28, relativeTo: .largeTitle).weight(.black)
    
    static let CardNutrient = Font.custom("Avenir Next", size: 16, relativeTo: .body).weight(.bold)
    static let CardNutrientSubtitle = Font.custom("Avenir", size: 14, relativeTo: .body).weight(.light)
}
