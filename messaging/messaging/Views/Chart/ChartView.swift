//
//  ChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

struct ChartView: View {
    @Binding var kind: Nutrient.Kind
    var profile = Profiles.arugula
    var body: some View {
        switch kind {
        case .macro:
            VerticalChartViewFDCapiTest(kind: $kind, nutrientProfile: profile)
        default:
            HorizontalChartViewFDCapiTest(kind: $kind, profile: profile)
        }
    }
}

#Preview {
    ChartView(kind: .constant(.macro))
}
