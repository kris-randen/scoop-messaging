//
//  FoodDetailMicrosView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI
import Foundation
import OrderedCollections

struct FoodDetailMicrosView: View {
    var foodMicrosProfile = Profiles.boostHighProteinDrink
    var kind: Nutrients.Kind = .mineral
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                CardView()
                ScrollView {
                    VStack {
                        foodItemAndNQI(name: foodMicrosProfile.description, value: -47)
                            .padding(.top)
                            .padding(.horizontal)
                        chart(profile: foodMicrosProfile, size: geo.size)
                    }
                    .minimumScaleFactor(0.8)
                }
            }
        }
        .padding()
    }
    
    fileprivate func foodItemAndNQI(name: String, value: Int) -> some View {
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
    
    fileprivate func chart(profile: NutrientProfile, size: CGSize) -> some View {
        let chartValues = parse(profile: profile)
        return VStack {
            charTitle()
            HStack(alignment: .center) {
                axisTitles(chart: chartValues!)
                    .padding(.leading, 10)
                    .frame(width: size.width/3.5)
                yAxis()
                    .padding(.trailing)
                    .foregroundColor(Colors.scoopRed)
                chartBars(chart: chartValues!, size: size)
                    .foregroundColor(Colors.scoopGreen)
            }
        }
    }
    
    fileprivate func parse(profile: NutrientProfile) -> (String, [(String, String, String, Double)])? {
        var result = (profile.description, [(String, String, String, Double)]())
        switch kind {
        case .vitamin:
            if let intakes = profile.intakes[kind] as? VitaminIntakes {
                for (key, value) in intakes.intakes.sorted(by: {$0.value > $1.value}) {
                    result.1.append((key.name, key.compound, key.unit.description, value))
                }
            } else {
                return nil
            }
        default:
            if let intakes = profile.intakes[kind] as? MineralIntakes {
                for (key, value) in intakes.intakes.sorted(by: {$0.value > $1.value}) {
                    result.1.append((key.name, key.compound, key.unit.description, value))
                }
            }
        }
        return result
    }
    
    fileprivate func charTitle() -> some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            Text("2000")
                .font(Fonts.Card.food.weight(.bold))
            Text("Cal")
                .font(Fonts.Card.food.weight(.light))
                .underline()
            Spacer()
            Text("Micros")
                .font(Fonts.Card.food.weight(.bold))
            Text(kind == .mineral ? "(Minerals)" : "(Vitamins)")
                .font(Fonts.Card.food.weight(.light))
                .underline()
            Spacer()
        }
    }
    
    fileprivate func axisTitles(chart: (String, [(String, String, String, Double)])) -> some View {
        return VStack {
            ForEach(chart.1, id: \.0) { item in
                VStack(alignment: .trailing) {
                    Text(item.0)
                        .font(Fonts.CardNutrient)
                    Text("(\(item.1))")
                        .font(Fonts.CardNutrientSubtitle)
                        .padding(.bottom, 5)
                    Spacer()
                }
            }
        }
    }
    
    fileprivate func yAxis() -> some View {
        FlexibleRoundedLine(orientation: .vertical, scaling: 0.99, width: 10)
            .frame(width: 15)
    }
    
    fileprivate func chartBars(chart: (String, [(String, String, String, Double)]), size: CGSize) -> some View {
        VStack {
            ForEach(chart.1, id: \.3) { item in
                VStack(alignment: .leading){
                    FlexibleRoundedLine(orientation: .horizontal, alignment: .leading, scaling: 0.03*item.3, width: (size.height * 0.5 / CGFloat(Nutrients.Micro.Vitamin.allCases.count)))
                    HStack(alignment: .firstTextBaseline) {
                        Text(String(format: "%.1fX", item.3))
                            .font(Fonts.CardNutrientSubtitle.weight(.black))
                        Text("Requirement")
                            .font(Fonts.CardNutrientSubtitle)
                    }
                    .foregroundColor(Colors.scoopRed)
                    .padding(.bottom, 5)
                    Spacer()
                }
            }
        }
    }
}

struct FoodDetailMicrosView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailMicrosView()
    }
}
