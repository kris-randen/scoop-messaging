//
//  Fonts.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import UIKit
import SwiftUI

struct Fonts {
    static let scoopLogoSignIn = Font.custom("Avenir", size: 42, relativeTo: .largeTitle).weight(.black)
    static let signInTextField = Font.custom("Avenir", size: 21, relativeTo: .caption).weight(.ultraLight)
    static let signInButtonLabel = Font.custom("Avenir", size: 24, relativeTo: .title2).weight(.black)
    static let signInTextFieldIcon = Font.custom("Avenir", size: 24, relativeTo: .caption).weight(.ultraLight)
    static let signInScreenSmall = Font.custom("Avenir", size: 16, relativeTo: .caption).weight(.bold)
}
