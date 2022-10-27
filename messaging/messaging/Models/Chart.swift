//
//  Chart.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/27/22.
//

import Foundation

struct Chart {
    struct Bar {
        let name: String
        let compound: String
        let unit: String
        let value: Double
        
        init(nutrient: any NutrientType, intake: Double) {
            self.name = nutrient.name
            self.compound = nutrient.compound
            self.unit = nutrient.unit.description
            self.value = intake
        }
    }
    
    let item: String
    let nqi: Int
    let energy: Int = 2000
    let title: (title: String, subtitle: String)
    var bars = [Bar]()
    
    init?(profile: NutrientProfile, kind: Nutrients.Kind, nqi: Int) {
        self.item = profile.description
        self.nqi = nqi
        self.title = kind.chartTitle
        switch kind {
        case .vitamin:
            guard let intakes = profile.intakes[kind] as? VitaminIntakes else { return nil }
            for (nutrient, intake) in intakes.intakes.descending {
                self.bars.append(Bar(nutrient: nutrient, intake: intake))
            }
        case .mineral:
            guard let intakes = profile.intakes[kind] as? MineralIntakes else { return nil }
            for (nutrient, intake) in intakes.intakes.descending {
                self.bars.append(Bar(nutrient: nutrient, intake: intake))
            }
        case .macro:
            guard let intakes = profile.intakes[kind] as? MacroIntakes else { return nil }
            for (nutrient, intake) in intakes.intakes.descending {
                self.bars.append(Bar(nutrient: nutrient, intake: intake))
            }
        }
    }
    
    func barWidth(for size: CGSize) -> CGFloat {
        (size.height * 0.5 / CGFloat(self.bars.count))
    }
}
