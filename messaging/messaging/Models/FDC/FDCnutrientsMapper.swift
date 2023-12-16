//
//  FDCnutrientMapper.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

class FDCnutrientsMapper {
    
    public static func map(_ nutrient: FDCfoodNutrient) -> any NutrientType {
        return Nutrients.fdcMap[nutrient.nutrientId]!
    }
    
    public static func map(_ intake: FDCfoodNutrientIntake) -> Intake {
        return (map(intake.foodNutrient), FDCUnits.value(for: intake))
    }
    
    public static func map(_ fdcUnit: FDCUnit) -> (any NutrientUnitType)? {
        return Units.table[fdcUnit]
    }
}

