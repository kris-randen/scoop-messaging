//
//  RoundedRectCaps.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

struct RoundedRectCaps: View {
    var line: RoundedRect
    
    var body: some View {
        ZStack {
            RoundedRectTopRightCap(line: line)
            RoundedRectTopLeftCap(line: line)
            RoundedRectBottomLeftCap(line: line)
            RoundedRectBottomRightCap(line: line)
        }
    }
}

struct RoundedRectCaps_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectCaps(line: RoundedRect(x: 0, y: 0, width: 100, height: 400, radiusScaling: 0.3))
    }
}
