//
//  RoundedRectView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import SwiftUI

struct RoundedRectView: View {
    var line: RoundedRect
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectCore(line: line)
            RoundedRectCaps(line: line)
        }
    }
}

struct RoundedRectView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectView(line: RoundedRect(x: 50, y: 100, width: 10, height: 40, radiusScaling: 0.2, orientation: .horizontal))
    }
}
