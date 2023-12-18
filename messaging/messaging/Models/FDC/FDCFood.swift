//
//  FDCFood.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

struct FDCFood: Decodable {
    let fdcId: Int
    let foodNutrients: [FDCfoodNutrientIntake]
    let servingSize: Double?
    let servingSizeUnit: String?
    let description: String
    
    var energy: Energy {
        let foodNutrient = foodNutrients.first { $0.nutrientName.lowercased() == "energy" }!
        return Energy(unit: .kcal, value: foodNutrient.value)
    }
}
