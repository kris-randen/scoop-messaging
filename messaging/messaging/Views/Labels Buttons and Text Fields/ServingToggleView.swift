//
//  ToggleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

struct ServingToggleView: View {
    var shape = Shapes.textField
    @Binding var serving: Serving.Kind
    var body: some View {
        HStack {
            Text("serving")
                .font(Fonts.badgeFont)
                .padding(.trailing)
            Button {
                serving = serving.toggle()
            } label: {
                BadgeView(badge: Badge(kind: .serving(kind: serving)))
            }
            .frame(width: 30)
            .padding(.trailing)
        }
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
    }
}

//#Preview {
//    ToggleView()
//}
