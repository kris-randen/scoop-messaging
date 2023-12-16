//
//  FoodNutrientParser.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

struct FoodNutrientParser {
    func parseFoods(from data: Data) throws -> [FDCFood]? {
        let decodedData = try JSONDecoder().decode(FDCFoodDataResponse.self, from: data)
        return decodedData.foods
    }
    
    func select(from foods: [FDCFood]) -> FDCFood? { foods.first }
    
    func extract(from food: FDCFood) -> any Serveable {
        Serving.get(from: food)
    }
    
    func extract(from food: FDCFood) -> NutrientIntakes {
        FDCUnits.nutrientIntakes(from: food.foodNutrients)
    }
    
    func extract(from food: FDCFood) -> NutrientProfile {
        NutrientProfile(
            intakes: extract(from: food),
            description: "",
            type: .value,
            serving: extract(from: food)
        )
    }
    
    func extractNQIprofile(from food: FDCFood) -> NutrientProfile {
        extract(from: food).convertedToNQI()
    }
}
