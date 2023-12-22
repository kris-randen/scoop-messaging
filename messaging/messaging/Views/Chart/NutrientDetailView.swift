//
//  ChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

struct NutrientDetailView: View {
    @Binding var kind: Nutrient.Kind
    var profile = Profiles.arugula
    var body: some View {
        switch kind {
        case .macro:
            VerticalChartView(kind: $kind, profile: profile)
        case .vitamin, .mineral:
            HorizontalChartView(kind: $kind, profile: profile)
        }
    }
}

#Preview {
    NutrientDetailView(kind: .constant(.macro))
}
