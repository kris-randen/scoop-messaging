//
//  NutrientDetailViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

struct NutrientDetailViewNew: View {
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var profile = Profiles.arugula
    var body: some View {
        HorizontalChartViewNew(kind: $kind, serving: $serving, profile: profile)
    }
}

#Preview {
    NutrientDetailViewNew(kind: .constant(.vitamin), serving: .constant(.kcal2000))
}
