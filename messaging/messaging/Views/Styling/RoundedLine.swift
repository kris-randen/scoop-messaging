//
//  RoundedLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/24/22.
//

import SwiftUI

struct RoundedLine: View {
    var line: CGRect
    var orientation: CGRect.Orientation
//    var orientation: CGRect.Orientation {
//        line.orientation
//    }
    var radius: CGFloat {
        switch orientation {
        case .vertical:
            return line.width/2
        case .horizontal:
            return line.height/2
        }
    }
    var body: some View {
        ZStack {
            Line(line: line)
            LineCaps(line: line, orientation: orientation)
        }
    }
}

struct RoundedLine_Previews: PreviewProvider {
    static var previews: some View {
        RoundedLine(line: CGRect(x: 100, y: 0, width: 30, height: 10), orientation: .vertical)
    }
}
