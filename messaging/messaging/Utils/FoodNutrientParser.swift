//
//  FoodNutrientParser.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/16/23.
//

import Foundation

struct FoodNutrientParser {
    static func parseFoods(from data: Data) -> [FDCFood]? {
        do {
            let decodedData = try JSONDecoder().decode(FDCFoodDataResponse.self, from: data)
            return decodedData.foods
        } catch {
            print("Error parsing foods from Data: \(error)")
            return nil
        }
    }
    
    static func select(from foods: [FDCFood]) -> FDCFood? {
        print("Food: \(foods.first!)")
        return foods.first
    }
    
    static func extract(from food: FDCFood) -> any ConvertibleMeasure {
        print("Extracting in FoodNutrientParser.extract from food: \(food)")
        return Serving.get(from: food)
    }
    
    static func extract(from food: FDCFood) -> NutrientIntakes {
        print("Food: \(food)")
        return FDCUnits.nutrientIntakesAll(from: food.foodNutrients)
    }
    
    static func extractNonNQIprofile(from food: FDCFood) -> NutrientProfile {
        NutrientProfile(
            intakes: extract(from: food),
            description: food.description,
            type: .value,
            serving: extract(from: food)
        )
    }
    
    static func energy(from food: FDCFood) -> Energy {
        food.energy
    }
    
    static func extract(from food: FDCFood) -> NutrientProfile {
        print("Extracting in FoodNutrientParser.extract from food: \(food)")
        return extractNonNQIprofile(from: food).convertedToNQI(for: food.energy)
    }
    
    static func extract(from data: Data) -> NutrientProfile {
        print("Extracting data.")
        return extract(from: select(from: parseFoods(from: data)!)!)
    }
}
