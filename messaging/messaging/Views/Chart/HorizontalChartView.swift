//
//  HorizontalChartViewFDCapiTest.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/18/23.
//

import SwiftUI
import Foundation
import OrderedCollections

struct HorizontalChartView: View {
    @Binding var kind: Nutrient.Kind
    var profile: NutrientProfile
    var orientation: Chart.Orientation { .horizontal }
    
    
    var chart: Chart {
        Chart(profile: profile, kind: kind, nqi: profile.nqi)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CardView()
                ScrollView {
                    VStack {
                        ItemDescriptionView(food: profile.food, nqi: profile.nqi)
                        ChartView(chart: chart, size: geo.size)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(kind.navigationTitle)
    }
}


#Preview {
    HorizontalChartView(kind: .constant(.macro), profile: Profiles.carrot)
}
