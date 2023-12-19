//
//  HorizontalChartViewFDCapiTest.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/18/23.
//

import SwiftUI
import Foundation
import OrderedCollections

struct HorizontalChartViewFDCapiTest: View {
//    var profileName: String
    @Binding var kind: Nutrients.Kind
    var profile: NutrientProfile
    
    
    var chart: Chart {
        Chart(profile: profile, kind: kind, nqi: profile.nqi)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CardView()
                ScrollView {
                    VStack {
//                        itemDescription(name: chart.item, nqi: chart.nqi)
                        itemDescription(name: profile.food, nqi: profile.nqi)
                            .padding(.top)
                            .padding(.horizontal)
                        chartView(for: chart, withSize: geo.size)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(kind.navigationTitle)
    }
    
    fileprivate func chartView(for chart: Chart, withSize size: CGSize) -> some View {
        return VStack {
            charTitle(for: chart)
            HStack(alignment: .center) {
                axisTitles(for: chart)
                    .padding(.leading, 10)
                    .frame(width: size.width/3.5, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                yAxis()
                    .padding(.horizontal, 5)
                    .foregroundColor(Colors.scoopRed)
                bars(for: chart, withSize: size)
            }
        }
    }
    
    fileprivate func itemDescription(name: String, nqi: Double) -> some View {
        HStack(alignment: .lastTextBaseline) {
            VStack {
                Text("\(name) 🕵🏻")
                    .font(Fonts.Card.food.weight(.bold))
                HStack {
                    Text("**NQI** = \(Int(nqi))")
                        .font(Fonts.Card.food.weight(.regular))
                    badge(kind: .food, forNQI: Int(nqi))
                }
            }
            .multilineTextAlignment(.center)
        }
    }
    
    fileprivate func badge(kind: Badge.Kind, forNQI nqi: Int) -> some View {
        BadgeView(
            badge: Badge(
                kind: kind,
                nqi: nqi
            )
        )
    }
    
    fileprivate func charTitle(for chart: Chart) -> some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            Text("\(chart.energy)")
                .font(Fonts.Card.food.weight(.bold))
            Text("Cal")
                .font(Fonts.Card.food.weight(.light))
                .underline()
            Spacer()
            Text("\(chart.title.title)")
                .font(Fonts.Card.food.weight(.bold))
            Text("(\(chart.title.subtitle))")
                .font(Fonts.Card.food.weight(.light))
                .underline()
            Spacer()
        }
    }
    
    fileprivate func axisTitles(for chart: Chart) -> some View {
        VStack {
            ForEach(chart.bars, id: \.name) { bar in
                axisTitle(bar)
            }
        }
    }
    
    fileprivate func axisTitle(_ bar: Chart.Bar) -> some View {
        VStack(alignment: .trailing) {
            Text(bar.name)
                .font(Fonts.CardNutrient)
            Text("(\(bar.compound))")
                .font(Fonts.CardNutrientSubtitle)
                .padding(.bottom, 5)
            Spacer()
        }
        .multilineTextAlignment(.trailing)
    }
    
    fileprivate func yAxis() -> some View {
        FlexibleRoundedLine(orientation: .vertical, scaling: 0.97, width: 10)
            .frame(width: 15)
    }
    
    fileprivate func bars(for chart: Chart, withSize size: CGSize) -> some View {
        VStack(alignment: .leading) {
            ForEach(chart.bars, id: \.name) { bar in
                barView(for: bar, in: chart, with: size)
            }
        }
    }
    
    fileprivate func barView(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 12){
            figure(for: bar, in: chart, with: size)
            legend(for: bar)
                .foregroundColor(Colors.scoopRed)
                .padding(.bottom, 5)
//            Spacer()
        }
//        .minimumScaleFactor(0.7)
    }
    
    fileprivate func figure(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View {
        FlexibleRoundedRect(
            orientation: .horizontal,
            alignment: .leading,
            scaling: bar.value < 0.6 ? 0.03 : 0.05 * (bar.value <= 18 ? bar.value : 18),
            width: chart.barWidth(for: size),
            radiusScaling: 0.4
        )
        .foregroundColor(bar.color)
    }
    
    fileprivate func legend(for bar: Chart.Bar) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(bar.value == 0 ? "ZERO" : description(for: bar.value))
                .font(Fonts.CardNutrientSubtitle.weight(.black))
                .fixedSize(horizontal: true, vertical: false)
            Text(bar.legend)
                .font(Fonts.CardNutrientSubtitle)
                .fixedSize(horizontal: true, vertical: false)
            if bar.value >= 8 {
                badge(kind: .nutrient, forNQI: 8)
//                .padding(.horizontal, 5)
            }
        }
        .foregroundColor(bar.legendColor)
        .padding(.bottom, 5)
    }
    
    func description(for value: Double) -> String {
        guard value > 1 else { return String(format: "%.0f", (value * 100)) + "%" }
        switch (value - floor(value)) {
        case 0...0.5:
            return String(format: "%.0fX", floor(value))
        case 0.5...1:
            return String(format: "%.0fX", ceil(value))
        default:
            return String(format: "%.0fX", value)
        }
    }
}


#Preview {
    HorizontalChartViewFDCapiTest(kind: .constant(.vitamin), profile: Profiles.carrot)
}
