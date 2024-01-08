//
//  HorizontalChartViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

struct HorizontalChartView: View {
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var profile: NutrientProfile
    var orientation: Chart.Orientation {
        .horizontal
    }
    
    var chart: Chart {
        Chart(profile: (serving == .gm100 ? profile.scaledByDV() : profile.convertedToNQI()), kind: kind, nqi: profile.nqi)
    }
    
    var body: some View {
        VStack {
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
            ProfileAndServingToggleView(shape: Shapes.textField, kind: $kind, serving: $serving)
        }
    }
}

#Preview {
    HorizontalChartView(kind: .constant(.vitamin), serving: .constant(.kcal2000), profile: Profiles.carrot)
}
