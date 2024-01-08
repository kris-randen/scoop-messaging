//
//  ScoopTextFieldAndToggle.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/8/24.
//

import SwiftUI

struct ScoopTextFieldAndToggle: View {
    var shape = Shapes.textField
    @Binding var text: String
    @Binding var kind: Nutrient.Kind
    @Binding var quantity: String
    @Binding var serving: Serving.Kind

    var body: some View {
        VStack {
            ScoopTextField(shape: shape, text: $text, kind: $kind)
            ProfileAndServingToggleView(shape: shape, kind: $kind, serving: $serving)
        }
        .foregroundColor(Colors.scoopRed)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
    }
}

#Preview {
    ScoopTextFieldAndToggle(text: .constant(""), kind: .constant(.macro), quantity: .constant("100"), serving: .constant(.kcal2000))
}
