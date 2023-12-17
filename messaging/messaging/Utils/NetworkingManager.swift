//
//  NetworkingManager.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

//
//  NetworkingManager.swift
//  scoop
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

struct NetworkingManager {
    
    func fetchNutritionalInfoOld(for foodItem: String) async -> String {
        let apiKey = "DEMO_KEY"
        let urlString = "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(foodItem)&api_key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            return "Invalid URL"
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return parseJSON(data) ?? "Error parsing data"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    func fetchNutritionalInfo(for foodItem: String) async -> NutrientProfile? {
        let apiKey = "DEMO_KEY"
        let urlString = "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(foodItem)&api_key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return FoodNutrientParser.extract(from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func fetchAndDecode(url: URL) async throws -> Any {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
    
    

    private func parseJSON(_ data: Data) -> String? {
        guard let foodNutrients = parseFoodNutrients(from: data) else { return nil }
        let nutrient = foodNutrients.first { $0.nutrientName == "Energy" }
        return "Calories: \(nutrient?.value ?? -10)"
    }
    
    private func parseFoodNutrients(from data: Data) -> [FDCfoodNutrientIntake]? {
        do {
            let decodedData = try JSONDecoder().decode(FDCFoodDataResponse.self, from: data)
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonData = jsonData as? [String: Any] else { return nil }
            guard let foods = jsonData["foods"] as? [[String: Any]] else { return nil }
            print("Number of foods = \(foods.count)")
            
            guard let food = decodedData.foods.first else {
                print("Food item not found")
                return nil
            }
            print("Food: \(food.description)")
            print("Serving Size: \(food.servingSize), Unit: \(food.servingSizeUnit)")
            print("Food Nutrients:")
            let nonZeroNutrients = food.foodNutrients.filter {$0.value > 0 }
            print("Number of non-zero nutrients: \(nonZeroNutrients.count)")
            for nutrient in nonZeroNutrients {
                print("\(nutrient)")
            }
            return food.foodNutrients
        } catch {
            print("Error decoding: \(error)")
            return nil
        }
    }
}
