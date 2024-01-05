//
//  BarsView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

struct BarsView: View {
    var chart: Chart
    var size: CGSize
    var orientation: Chart.Orientation = .horizontal
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(chart.bars, id: \.name) { bar in
                barView(for: bar, in: chart, with: size)
            }
        }
    }
    
    fileprivate func barView(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View
    {
        VStack(alignment: .leading, spacing: 12){
            figure(for: bar, in: chart, with: size)
            legend(for: bar)
                .foregroundColor(Colors.scoopRed)
                .padding(.bottom, 6)
        }
    }
    
    fileprivate func figure(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View {
        FlexibleRoundedRect(
            orientation: .horizontal,
            alignment: .leading,
            scaling: scaling(for: bar),
            width: chart.barWidth(for: size),
            radiusScaling: 0.4
        )
        .foregroundColor(bar.color)
    }
    
    fileprivate func legend(for bar: Chart.Bar) -> some View {
        HStack(alignment: .bottom) {
            Text(bar.value == 0 ? "ZERO" : description(for: bar.value))
                .font(Fonts.CardNutrientSubtitle.weight(.black))
                .fixedSize(horizontal: true, vertical: false)
            Text(bar.legend)
                .font(Fonts.CardNutrientSubtitle)
                .fixedSize(horizontal: true, vertical: false)
            if bar.value >= 8 {
                BadgeView(badge: Badge(kind: .nutrient, nqi: 8))
                    .padding(.horizontal, 5)
            }
        }
        .foregroundColor(bar.legendColor)
        .padding(5)
    }
    
    fileprivate func scaling(for bar: Chart.Bar) -> Double {
        switch orientation {
        case .horizontal:
            bar.value < 0.6 ? 0.03 : 0.05 * (bar.value <= 18 ? bar.value : 18)
        case .vertical:
            bar.value < 0.6 ? 0.03 : 0.08 * bar.value
        }
    }
    
    func description(for value: Double) -> String {
        switch (value - floor(value)) {
        case 0.25...0.75:
            return String(format: "%.1fX", (floor(value) + 0.5))
        case 0...0.25:
            return String(format: "%.0fX", floor(value))
        case 0.75...1:
            return String(format: "%.0fX", ceil(value))
        default:
            return String(format: "%.1fX", value)
        }
    }
}

#Preview {
    BarsView(chart: Chart(profile: Profiles.carrot, kind: .vitamin), size: Constants.screen.size)
}