//
//  VerticalLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

struct VerticalLine: View {
    var origin = CGPoint(x: 25, y: 25)
    var length = CGFloat(500)
    var width = CGFloat(10)
    var body: some View {
        Path { path in
            path.move(to: origin)
            path.addLine(to: CGPoint(x: origin.x, y: origin.y + length))
            path.addArc(center: CGPoint(x: origin.x + width/2, y: origin.y + length), radius: width/2, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: false)
            path.addLine(to: CGPoint(x: origin.x + width, y: origin.y + length))
            path.addLine(to: CGPoint(x: origin.x + width, y: origin.y))
            path.addArc(center: CGPoint(x: origin.x + width/2, y: origin.y), radius: width/2, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: true)
            path.addLine(to: origin)
        }
    }
}

struct VerticalLine_Previews: PreviewProvider {
    static var previews: some View {
        VerticalLine()
    }
}
