//
//  Serving.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

struct Serving {
    
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
        guard let unit = food.servingSizeUnit else { return Mass() }
        var serving = mapper[Units.Kind.get(from: food.servingSizeUnit!.lowercased())!]!
        serving.value = food.servingSize!
        return serving
    }
}

