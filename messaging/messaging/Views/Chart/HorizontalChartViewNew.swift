//
//  HorizontalChartViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

struct HorizontalChartViewNew: View {
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var profile: NutrientProfile
    var orientation: Chart.Orientation {
        .horizontal
    }
    
    var chart: Chart {
        Chart(profile: profile, kind: kind, nqi: profile.nqi)
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
    HorizontalChartViewNew(kind: .constant(.vitamin), serving: .constant(.kcal2000), profile: Profiles.carrot)
}
