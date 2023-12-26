//
//  NutrientDetailView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/26/23.
//

import SwiftUI

struct NutrientDetailView: View {
    @Binding var kind: Nutrient.Kind
    var profile = Profiles.arugula
    var body: some View {
        HorizontalChartView(kind: $kind, profile: profile)
    }
}

#Preview {
    NutrientDetailView(kind: .constant(.vitamin))
}
