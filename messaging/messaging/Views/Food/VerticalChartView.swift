//
//  VerticalChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/28/22.
//

import SwiftUI

struct VerticalChartView: View {
    var profile: String
    @Binding var kind: Nutrients.Kind
    var nutrientProfile: NutrientProfile {
        Profiles.dict[profile.lowercased()]!
    }
    
    var chart: Chart {
        Chart(profile: nutrientProfile, kind: kind, nqi: nutrientProfile.nqi)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CardView()
                VStack(alignment: .center) {
                    itemDescription(name: chart.item, nqi: chart.nqi)
//                    itemDescription(name: chart.item, nqi: 100)
                        .padding(.top)
                        .padding(.horizontal)
                    chartView(for: chart, withSize: geo.size)
                }
            }
            .padding()
        }
        .navigationTitle(kind.navigationTitle)
    }
    
    fileprivate func chartView(for chart: Chart, withSize size: CGSize) -> some View {
        VStack {
            charTitle(for: chart)
            Spacer()
            HStack(alignment: .bottom) {
                axisTitles(for: chart)
                    .padding(.leading, 10)
                    .frame(width: size.width/3.5, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                yAxis()
                    .padding(.horizontal, 5)
                    .foregroundColor(Colors.scoopRed)
                bars(for: chart, withSize: size)
            }
            .frame(height: 0.8 * Constants.Width)
            .rotationEffect(270.degrees)
        }
    }
    
    fileprivate func itemDescription(name: String, nqi: Double) -> some View {
        HStack(alignment: .lastTextBaseline) {
            VStack {
                Text("\(name)🕵🏻")
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
            if chart.kind == .macro {
                HStack {
                    Text(String(format: "%.0f", value(forNutrient: bar.nutrient, ofKind: bar.kind, withNQI: bar.value)))
                        .fontWeight(.black)
                    Text("\(bar.unit)")
                        .padding(.leading, -3)
                }
                    .font(Fonts.nutrientValue)
                    .padding(.bottom, 5)
            } else {
                Text("(\(bar.compound))")
                    .font(Fonts.CardNutrientSubtitle)
                    .padding(.bottom, 5)
            }
            Spacer()
        }
        .multilineTextAlignment(.trailing)
    }
    
    fileprivate func value(forNutrient nutrient: any NutrientType, ofKind kind: Nutrients.Kind, withNQI nqi: Double) -> Double {
        switch kind {
        case .macro:
            let intakes = (Profiles.profile.intakes.intakes[kind] as! MacroIntakes).intakes
            return nqi * intakes[nutrient as! MacroIntakes.Nutrient]!
        case .vitamin:
            let intakes = (Profiles.profile.intakes.intakes[kind] as! VitaminIntakes).intakes
            return nqi * intakes[nutrient as! VitaminIntakes.Nutrient]!
        case .mineral:
            let intakes = (Profiles.profile.intakes.intakes[kind] as! MineralIntakes).intakes
            return nqi * intakes[nutrient as! MineralIntakes.Nutrient]!
        }
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
        VStack(alignment: .leading){
            figure(for: bar, in: chart, with: size)
            legend(for: bar)
                .foregroundColor(Colors.scoopRed)
                .padding(.bottom, 5)
            Spacer()
        }
    }
    
    fileprivate func figure(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View {
        FlexibleRoundedRect(
            orientation: .horizontal,
            alignment: .leading,
            scaling: bar.value < 0.6 ? 0.03 : 0.08 * bar.value,
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
                    .padding(.horizontal, 5)
            }
        }
        .foregroundColor(bar.legendColor)
        .padding(5)
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

struct VerticalChartView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalChartView(profile: "sugar", kind: .constant(.macro))
//        VerticalChartView(profile: .constant("boost high protein drink"), kind: .constant(.macro))
//        VerticalChartView(profile: .constant("sugar"), kind: .constant(.macro))
    }
}
