//
//  FoodDetailMicrosView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI
import Foundation
import OrderedCollections

struct HorizontalChartView: View {
    var chart: Chart
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CardView()
                ScrollView {
                    VStack {
                        itemDescription(name: chart.item, value: chart.nqi)
                            .padding(.top)
                            .padding(.horizontal)
                        chartView(for: chart, withSize: geo.size)
                    }
                    .minimumScaleFactor(0.8)
                }
            }
        }
        .padding()
    }
    
    fileprivate func itemDescription(name: String, value: Int) -> some View {
        HStack(alignment: .lastTextBaseline) {
            VStack {
                Text("\(name) 🦉 🌈")
                    .font(Fonts.Card.food.weight(.bold))
                Text("**NQI** = \(value)")
                    .font(Fonts.Card.food.weight(.regular))
            }
            .multilineTextAlignment(.center)
        }
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
                    .foregroundColor(Colors.scoopGreen)
                    .frame(alignment: .leading)
            }
        }
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
    
    fileprivate func bars(for chart: Chart, withSize size: CGSize) -> some View {
        VStack {
            ForEach(chart.bars, id: \.name) { bar in
                barView(for: bar, in: chart, with: size)
            }
        }
    }
    
    fileprivate func yAxis() -> some View {
        FlexibleRoundedLine(orientation: .vertical, scaling: 0.99, width: 10)
            .frame(width: 15)
    }
    
    fileprivate func figure(for bar: Chart.Bar, in chart: Chart, with size: CGSize) -> some View {
        FlexibleRoundedLine(
            orientation: .horizontal,
            alignment: .leading,
            scaling: 0.03*bar.value,
            width: chart.barWidth(for: size))
    }
    
    fileprivate func legend(for bar: Chart.Bar) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(String(format: "%.1fX", bar.value))
                .font(Fonts.CardNutrientSubtitle.weight(.black))
            Text("Requirement")
                .font(Fonts.CardNutrientSubtitle)
        }
    }
}

struct HorizontalChartView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalChartView(chart: Chart(profile: Profiles.boostHighProteinDrink, kind: .mineral, nqi: -47)!)
    }
}
