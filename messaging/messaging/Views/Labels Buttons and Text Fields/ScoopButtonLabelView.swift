//
//  ScoopButtonLabelView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

struct ScoopButtonLabelView: View {
    var name: String = "Scoop"
    var shape: Modifiers.Shapes = Shapes.textField
    
    var body: some View {
        Text(name)
            .foregroundColor(Colors.scoopRed)
            .font(Fonts.fullWidthButtonLabel)
            .fullYellowButtonify(height: .height(scaling: Dimensions.HeightScaling.button, tolerance: 0))
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
    }
}

#Preview {
    ScoopButtonLabelView()
}
