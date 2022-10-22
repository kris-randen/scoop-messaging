//
//  Labels.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI
import Foundation
import Kingfisher

enum LabelType: String, CaseIterable {
    case like = "heart.fill"
    case unlike = "heart"
    case comment = "bubble.right"
    case share = "paperplane"
    
    case verified = "checkmark.seal.fill"
    case search = "magnifyingglass"
    case chevronDown = "chevron.down"
    
    case eyeOpen = "eye"
    case eyeClosed = "eye.slash"
    case person = "person"
    case personPlus = "person.badge.plus"
    case personInACircle = "person.circle"
    case camera = "camera"
    case cameraFill = "camera.fill"
    case cameraCircle = "camera.circle"
    case cameraCircleFill = "camera.circle.fill"
    case plus = "plus"
    case trash = "trash"
}

enum LabelErrors: Error {
    case imageNotFound(description: String)
    case videoNotFound(description: String)
    case contentNotFound(description: String)
}

struct Labels {
    static let screen = UIScreen.main.bounds
    
    static let unlike: some View = image(for: .unlike)
    static let like: some View = image(for: .like, withColor: .red)
    static let comment: some View = image(for: .comment).rotation3DEffect(Angle.degrees(180), axis: (x: 0, y: 1, z: 0))
    static let share: some View = image(for: .share)
    static let verified: some View = image(for: .verified)
    static let verifiedBlue: some View = image(for: .verified, withColor: .blue)
    
    static let passwordVisible: some View = image(for: .eyeOpen)
    static let passwordInvisible: some View = image(for: .eyeClosed)
    
    static let userNameLabelFont: Font = Font.headline.weight(.semibold)
    static let search: some View = image(for: .search)
    
    static func image(for label: LabelType) -> some View {
        image(for: label, withColor: .black)
    }
    
    static func image(for label: LabelType, withColor color: Color) -> some View {
        Image(systemName: label.rawValue).foregroundColor(color)
    }
    
    static func image(for label: LabelType, withFont: Font, withColor color: Color) -> some View {
        image(for: label, withColor: color)
    }
    
    static func roundButton(for label: LabelType, backgroundColor: Color, foregroundColor: Color) -> some View {
        ZStack {
            Circle()
                .foregroundColor(backgroundColor)
                .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
            image(for: label, withFont: .largeTitle.weight(.thin), withColor: foregroundColor)
        }
    }
}
