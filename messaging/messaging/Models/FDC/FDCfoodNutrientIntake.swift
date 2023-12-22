//
//  FDCNutrientIntake.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

struct FDCfoodNutrientIntake: Decodable {
    let nutrientId: Int
    let nutrientNumber: String
    let nutrientName: String
    let value: Double
    let unitName: String
    
    var foodNutrient: FDCfoodNutrient {
        return FDCfoodNutrient(nutrientId: nutrientId, nutrientNumber: nutrientNumber, nutrientName: nutrientName)
    }
    var nutrient: any NutrientType {
        return foodNutrient.nutrient
    }
    var unit: any NutrientUnitType {
        return Units.table[unitName.lowercased()]!
    }
//    var measure: FDCMeasure {
//        return FDCMeasure(unitName: unitName, value: value)
//    }
}
