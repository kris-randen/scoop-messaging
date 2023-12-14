//
//  FDCUnit.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

typealias FDCUnit = String

struct FDCUnits {
    static let masses: Set = ["kg", "g", "mg", "ug"]
    static let lengths: Set = ["km", "m","cm", "mm"]
    static let volumes: Set = ["l", "dl", "ml"]
    
    static func conversion(for intake: FDCfoodNutrientIntake) -> Double {
        let (name, unit) = (intake.unitName, intake.unit)
        let desc = unit.description
    
        if masses.contains(name) {
            return Units.Mass.table[name]!.conversion(to: Units.Mass.table[desc]!)
        }
        else if lengths.contains(name) {
            return Units.Length.table[name]!.conversion(to: Units.Length.table[desc]!)
        }
        else if volumes.contains(name) {
            return Units.Volume.table[name]!.conversion(to: Units.Volume.table[desc]!)
        }
        return 0
    }
    
    static func value(for intake: FDCfoodNutrientIntake) -> Double {
        return intake.value * conversion(for: intake)
    }
    
    static func convert(intake: FDCfoodNutrientIntake) -> Intake {
        return (intake.nutrient, value(for: intake))
    }
    
    static func convert(intakes: [FDCfoodNutrientIntake]) {
        
    }
}
