//
//  Serving.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

struct Serving {
    enum Kind {
        case gm100, kcal2000
        
        var name: String {
            switch self {
            case .gm100: "100 gm"
            case .kcal2000: "2000 Cal"
            }
        }
        
        func toggle() -> Kind {
            switch self {
            case .gm100: 
                    return .kcal2000
            case .kcal2000: 
                    return .gm100
            }
        }
    }
    
    struct Volume: ConvertibleMeasure {
        typealias Unit = Units.Volume
        var unit: Unit = .ml
        var value: Double = 1000
    }

    struct Mass: ConvertibleMeasure {
        typealias Unit = Units.Mass
        var unit: Unit = .gm
        var value: Double = 100
    }
    
    static var mapper: [Units.Kind : any ConvertibleMeasure] {
        [
            .mass: Mass(),
            .volume: Volume()
        ]
    }
    
    static func get(from food: FDCFood) -> any ConvertibleMeasure {
        print("The food is:\n\(food)")
        guard food.servingSizeUnit != nil else { return Mass() }
        var serving = mapper[Units.Kind.get(from: food.servingSizeUnit!.lowercased())!]!
        serving.value = food.servingSize!
        return serving
    }
}

