//
//  FlexibleVerticalLine.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

struct FlexibleVerticalLine: View {
    var offset = CGPoint(x: 25, y: 25)
    var lengthScaling = CGFloat(1)
    var width = CGFloat(10)
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                
                let origin = geo.frame(in: .local).origin + offset
                let height = geo.size.height*lengthScaling
                let bottomLeft = origin + CGPoint(x: 0, y: height)
                let bottomRight = origin + CGPoint(x: width, y: height)
                let topRight = origin + CGPoint(x: width, y: 0)
                let bottomArcCenter = bottomLeft + CGPoint(x: width/2, y: 0)
                let topArcCenter = origin + CGPoint(x: width/2, y: 0)
                
                path.move(to: origin)
                path.addLine(to: bottomLeft)
                path.addArc(center: bottomArcCenter, radius: width/2, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: false)
                path.addLine(to: bottomRight)
                path.addLine(to: topRight)
                path.addArc(center: topArcCenter, radius: width/2, startAngle: 0.degrees, endAngle: 180.degrees, clockwise: true)
                path.addLine(to: origin)
            }
        }
    }
}

struct FlexibleVerticalLine_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleVerticalLine()
    }
}
