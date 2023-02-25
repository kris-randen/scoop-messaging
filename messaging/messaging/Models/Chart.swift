//
//  Chart.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import Foundation
import SwiftUI
import OrderedCollections

struct Chart {
    struct Bar {
        let name: String
        let compound: String
        let unit: String
        let value: Double
        let nutrient: any NutrientType
        var kind: Nutrients.Kind = .vitamin
        
        init(nutrient: any NutrientType, intake: Double, kind: Nutrients.Kind) {
            self.nutrient = nutrient
            self.name = nutrient.name
            self.compound = nutrient.compound
            self.unit = nutrient.unit.description
            self.value = intake
            self.kind = kind
        }
        
        init(nutrient: VitaminIntakes.Nutrient, intake: Double) {
            self.init(nutrient: nutrient as VitaminIntakes.Nutrient, intake: intake, kind: .vitamin)
        }
        
        init(nutrient: MineralIntakes.Nutrient, intake: Double) {
            self.init(nutrient: nutrient as MineralIntakes.Nutrient, intake: intake, kind: .mineral)
        }
        
        init(nutrient: MacroIntakes.Nutrient, intake: Double) {
            self.init(nutrient: nutrient as MacroIntakes.Nutrient, intake: intake, kind: .macro)
        }
        
        var legend: String {
            guard value != 0 else { return name }
            print("Bar Nutrient = \(nutrient.name)")
            return nutrient.required ? "Required" : "Allowed"
        }
        
        var color: Color {
            guard value != 0 else { return Color.black }
            return nutrient.required ? Colors.scoopGreen : Color.black
        }
        
        var legendColor: Color {
            guard value != 0 else { return Colors.scoopBlue }
            return nutrient.required ? Colors.scoopRed : Color.black
        }
    }
    
    static let zeroVitaminBars = [
        Bar(nutrient: .a, intake: 0),
        Bar(nutrient: .d, intake: 0),
        Bar(nutrient: .e, intake: 0),
        Bar(nutrient: .k, intake: 0),
        Bar(nutrient: .b9, intake: 0),
        Bar(nutrient: .b12, intake: 0),
        Bar(nutrient: .c, intake: 0),
        Bar(nutrient: .b1, intake: 0),
        Bar(nutrient: .b2, intake: 0),
        Bar(nutrient: .b3, intake: 0),
        Bar(nutrient: .b4, intake: 0),
        Bar(nutrient: .b5, intake: 0),
        Bar(nutrient: .b6, intake: 0),
        Bar(nutrient: .b7, intake: 0)
    ]
    
    static let zeroMineralBars = [
        Bar(nutrient: .Na, intake: 0),
        Bar(nutrient: .Fe, intake: 0),
        Bar(nutrient: .Mg, intake: 0),
        Bar(nutrient: .Ca, intake: 0),
        Bar(nutrient: .I, intake: 0),
        Bar(nutrient: .Se, intake: 0),
        Bar(nutrient: .Zn, intake: 0),
        Bar(nutrient: .Cu, intake: 0),
        Bar(nutrient: .Mn, intake: 0),
        Bar(nutrient: .Cr, intake: 0),
        Bar(nutrient: .Mo, intake: 0),
        Bar(nutrient: .P, intake: 0),
        Bar(nutrient: .F, intake: 0),
        Bar(nutrient: .K, intake: 0),
        Bar(nutrient: .Cl, intake: 0)
    ]
    
    static let zeroMacroBars = [
        Bar(nutrient: .sugar, intake: 0),
        Bar(nutrient: .cholesterol, intake: 0),
        Bar(nutrient: .transFat, intake: 0),
        Bar(nutrient: .carbs, intake: 0),
        Bar(nutrient: .fats, intake: 0),
        Bar(nutrient: .fiber, intake: 0)
    ]
    
    static func zeroBars(for nutrients: [any NutrientType], kind: Nutrients.Kind) -> [Bar] {
        nutrients.map {Bar.init(nutrient: $0, intake: 0, kind: kind)}
    }
    
    static func bars(for intakes: some Intakeable, kind: Nutrients.Kind) -> [Bar] {
        return intakes.intakes.descending.map { Bar.init(nutrient: $0, intake: $1, kind: kind) }
//        switch kind {
//        case .vitamin:
//            guard let intakes = intakes as? VitaminIntakes else { return Chart.zeroVitaminBars }
//            return intakes.intakes.descending.map {Bar.init(nutrient: $0, intake: $1, kind: kind)}
//
//        case .mineral:
//            guard let intakes = intakes as? MineralIntakes else { return Chart.zeroMineralBars }
//            return intakes.intakes.descending.map {Bar.init(nutrient: $0, intake: $1, kind: kind)}
//
//        case .macro:
//            guard let intakes = intakes as? MineralIntakes else { return Chart.zeroMacroBars }
//            return intakes.intakes.descending.map {Bar.init(nutrient: $0, intake: $1, kind: kind)}
//        }
    }
    
    static func barsAll(for intakes: some Intakeable, kind: Nutrients.Kind) -> [Bar] {
        switch kind {
        case .vitamin:
            guard let intakes = intakes as? VitaminIntakes else { return Chart.zeroVitaminBars }
            return Chart.bars(for: intakes, kind: kind) //+ Chart.bars(for: nutrientsComplement(for: intakes, kind: kind), kind: kind)
            
        case .mineral:
            guard let intakes = intakes as? MineralIntakes else { return Chart.zeroMineralBars }
            return bars(for: intakes, kind: kind) //+ bars(for: nutrientsComplement(for: intakes, kind: kind), kind: kind)
            
        case .macro:
            guard let intakes = intakes as? MacroIntakes else { return Chart.zeroMacroBars }
            return bars(for: intakes, kind: kind) //+ bars(for: nutrientsComplement(for: intakes, kind: kind), kind: kind)
        }
    }
    
//    static func intakesComplement(for intakes: some Intakeable, kind: Nutrients.Kind) -> any Intakeable {
//        switch kind {
//        case .vitamin:
//            
//        }
//    }
    
    static func nutrientsComplement(for intakes: some Intakeable, kind: Nutrients.Kind) -> [any NutrientType] {
        switch kind {
        case .vitamin:
            let allVitamins = Nutrients.Micro.Vitamin.allCases
            guard let intakes = intakes as? VitaminIntakes else { return allVitamins }
            return allVitamins.filter { !intakes.intakes.keys.contains($0) }
            
        case .mineral:
            let allMinerals = Nutrients.Micro.Mineral.allCases
            guard let intakes = intakes as? MineralIntakes else { return allMinerals }
            return allMinerals.filter { !intakes.intakes.keys.contains($0) }
            
        case .macro:
            let allMacros = Nutrients.Macro.allCases
            guard let intakes = intakes as? MacroIntakes else { return allMacros }
            return allMacros.filter { !intakes.intakes.keys.contains($0) }
        }
    }
    
    let item: String
    let nqi: Double
    let energy: Int = 2000
    let title: (title: String, subtitle: String)
    var bars = [Bar]()
//    var barsAll: OrderedDictionary<Nutrients.Kind, [Bar]>
    let kind: Nutrients.Kind
    
    init(profile: NutrientProfile, kind: Nutrients.Kind, nqi: Double = 0) {
        self.item = profile.description
        self.nqi = profile.nqi
        self.title = kind.chartTitle
        self.kind = kind
        
//        for kind in profile.intakes.keys {
//            self.barsAll[kind] = profile.intakes[kind]!.intakes.descending.map({ (key: NutrientType, value: Double) in
//                return Bar(nutrient: key, intake: value, kind: kind)
//            })
//        }
        
        switch kind {
        case .vitamin:
            guard let intakes = profile.intakes.intakes[kind] as? VitaminIntakes else {
                self.bars = Chart.zeroVitaminBars
                return
            }
            for (nutrient, intake) in intakes.intakes.descending {
                self.bars.append(Bar(nutrient: nutrient, intake: intake))
            }
            
        case .mineral:
            guard let intakes = profile.intakes.intakes[kind] as? MineralIntakes else {
                self.bars = Chart.zeroMineralBars
                return
            }
            
            for (nutrient, intake) in intakes.intakes.descending {
                self.bars.append(Bar(nutrient: nutrient, intake: intake))
            }
            
        case .macro:
            guard let intakes = profile.intakes.intakes[kind] as? MacroIntakes else {
                self.bars = Chart.zeroMacroBars
                return
            }
            for (nutrient, intake) in intakes.intakes.descending {
                if displayBars.map({$0.name}) .contains(nutrient.name) {
                    self.bars.append(Bar(nutrient: nutrient, intake: intake, kind: self.kind))
                }
            }
        }
    }
    
    var displayBars: [Nutrients.Macro] {
        [.sugar, .carbs, .fats, .protein, .fiber]
    }
    
    func barWidth(for size: CGSize) -> CGFloat {
        min(25, (size.height * 0.5 / CGFloat(self.bars.count)))
    }
}
