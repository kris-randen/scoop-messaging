//
//  FDCfoodNutrient.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

struct FDCfoodNutrient: Decodable {
    let nutrientId: Int
    let nutrientNumber: String
    let nutrientName: String
    
    var nutrient: any NutrientType {
        return Nutrient.fdcMap[nutrientId]!
    }
}
