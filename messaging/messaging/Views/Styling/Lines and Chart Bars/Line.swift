//
//  Line.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/25/22.
//

import SwiftUI

struct Line: View {
    var line: CGRect
    
    var body: some View {
        Path { path in
            path.move(to: line.topLeftGlobal)
            path.addLine(to: line.bottomLeftGlobal)
            path.addLine(to: line.bottomRightGlobal)
            path.addLine(to: line.topRightGlobal)
            path.addLine(to: line.topLeftGlobal)
        }
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line(line: CGRect(x: 100, y: 0, width: 45, height: 400))
    }
}
