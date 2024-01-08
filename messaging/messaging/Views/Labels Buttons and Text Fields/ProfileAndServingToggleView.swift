//
//  ProfileAndServingToggleView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

struct ProfileAndServingToggleView: View {
    var shape = Shapes.textField
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            ProfileToggleView(shape: shape, kind: $kind)
            Spacer()
            ServingToggleView(shape: shape, serving: $serving)
            Spacer()
        }
        .foregroundColor(Colors.scoopRed)
    }
}

#Preview {
    ProfileAndServingToggleView(kind: .constant(.vitamin), serving: .constant(.kcal2000))
}
