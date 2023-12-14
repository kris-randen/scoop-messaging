//
//  FDCnutrientMapper.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/14/23.
//

import Foundation

class FDCnutrientsMapper {
    
    public static func map(_ nutrient: FDCfoodNutrient) -> any NutrientType {
        return Nutrients.FDCmap[nutrient.nutrientId]!
    }
    
    public static func map(_ intake: FDCfoodNutrientIntake) -> Intake {
        return (map(intake.foodNutrient), FDCUnits.value(for: intake))
    }
    
    public static func map(_ fdcUnit: FDCUnit) -> (any UnitType)? {
        return Units.table[fdcUnit]
    }
}

