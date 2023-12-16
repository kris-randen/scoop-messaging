//
//  Serving.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

protocol Serveable {
    associatedtype ServingUnit: UnitType
    var unit: ServingUnit { get }
    var value: Double { get set }
}

struct Serving {
    
    struct Volume: Serveable {
        typealias ServingUnit = Units.Volume
        var unit: Units.Volume = .ml
        var value: Double = 1000
    }

    struct Mass: Serveable {
        typealias ServingUnit = Units.Mass
        var unit: Units.Mass = .gm
        var value: Double = 100
    }
    
    static var mapper: [Units.Kind : any Serveable] {
        [
            .mass: Mass(),
            .volume: Volume()
        ]
    }
    
    static func get(from food: FDCFood) -> any Serveable {
        var serving = mapper[Units.Kind.get(from: food.servingSizeUnit!)!]!
        serving.value = food.servingSize!
        return serving
    }
}

