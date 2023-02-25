//
//  RoundedRectCore.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

struct RoundedRectCore: View {
    enum Flank {
        case top
        case right
        case bottom
        case left
    }
    
    var line: RoundedRect
    
    var body: some View {
        ZStack {
            center(line: line)
            flanks(line: line)
        }
    }
    
    fileprivate func center(line: RoundedRect) -> some View {
        Path { path in
            path.move(to: line.topLeftCenterGlobal)
            path.addLine(to: line.topRightCenterGlobal)
            path.addLine(to: line.bottomRightCenterGlobal)
            path.addLine(to: line.bottomLeftCenterGlobal)
        }
    }
    
    fileprivate func flanks(line: RoundedRect) -> some View {
        ZStack {
            flank(line: line, flank: .left)
            flank(line: line, flank: .top)
            flank(line: line, flank: .right)
            flank(line: line, flank: .bottom)
        }
    }
    
    fileprivate func flank(line: RoundedRect, flank: Flank) -> some View {
        switch flank {
        case .left:
            return Line(line: line.leftFlank)
        case .right:
            return Line(line: line.rightFlank)
        case .top:
            return Line(line: line.topFlank)
        case .bottom:
            return Line(line: line.bottomFlank)
        }
    }
}

struct RoundedRectCore_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectCore(line: RoundedRect(x: 100, y: 500, width: 250, height: 100, radiusScaling: 0.2))
    }
}
