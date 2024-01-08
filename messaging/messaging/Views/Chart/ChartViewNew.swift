//
//  ChartViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

struct ChartViewNew: View {
    var chart: Chart
    var size: CGSize
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    
    var body: some View {
        VStack {
            ChartTitleViewNew(chart: chart, kind: $kind, serving: $serving)
            Spacer()
            ChartBodyViewVariable(chart: chart, size: size, orientation: .horizontal)
            .chartFramify()
        }
    }
}

#Preview {
    ChartViewNew(chart: Chart(profile: Profiles.arugula, kind: .macro), size: Constants.screen.size, kind: .constant(.vitamin), serving: .constant(.kcal2000))
}
