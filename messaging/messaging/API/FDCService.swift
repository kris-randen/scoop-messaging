//
//  FDCService.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

struct FDCService {
    
    func fetchFDCfoodNutrientIntakes(for foodItem: String) async throws -> [FDCfoodNutrientIntake]? {
        guard let url = fdcURL(for: foodItem) else { return nil }
        let (data, _) = try await fetchData(from: url)
        return try parseFoodNutrients(from: data)
    }
    
    private func parseFoodNutrients(from data: Data) throws -> [FDCfoodNutrientIntake]? {
        let decodedData = try JSONDecoder().decode(FDCFoodDataResponse.self, from: data)
        guard let food = decodedData.foods.first else { return nil }
        return food.foodNutrients
    }
    
    private func fdcURL(for foodItem: String, using key: String = Constants.APIkeyFDC) -> URL? {
        return URL(string: "\(Constants.APIurlstringFDC)?query=\(foodItem)&api_key=\(key)")
    }
    
    private func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(from: url)
    }
}
    
    
    
    
    
    
    
    
//    private func fetchJSONobject(url: URL) async throws -> Any {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return try JSONSerialization.jsonObject(with: data, options: [])
//    }
    
    
    //    func fetchNutritionalInfoString(for foodItem: String) async -> String {
    //        guard let url = fdcURL(for: foodItem) else { return "Invalid URL" }
    //
    //        do {
    //            return try await fetchData(from: url) ?? "Error parsing"
    //        } catch {
    //            return "Error: \(error.localizedDescription)"
    //        }
    //    }

//    private func parseJSON(_ data: Data) -> String? {
//        guard let foodNutrients = parseFoodNutrients(from: data) else { return nil }
//        let nutrient = foodNutrients.first { $0.nutrientName == "Energy" }
//        return "Calories: \(nutrient?.value ?? -10)"
//    }
    
    //    private func parseFoodNutrients(from data: Data) -> [FDCNutrientIntake]? {
    //        do {
    //            let decodedData = try JSONDecoder().decode(FDCFoodDataResponse.self, from: data)
    ////            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
    ////            guard let jsonData = jsonData as? [String: Any] else { return nil }
    ////            guard let foods = jsonData["foods"] as? [[String: Any]] else { return nil }
    ////            print("Number of foods = \(foods.count)")
    //
    //            guard let food = decodedData.foods.first else {
    //                print("Food item not found")
    //                return nil
    //            }
    ////            print("Food: \(food.description)")
    ////            print("Serving Size: \(food.servingSize), Unit: \(food.servingSizeUnit)")
    ////            print("Food Nutrients:")
    ////            let nonZeroNutrients = food.foodNutrients.filter {$0.value > 0 }
    ////            print("Number of non-zero nutrients: \(nonZeroNutrients.count)")
    ////            for nutrient in nonZeroNutrients {
    ////                print("\(nutrient)")
    ////            }
    //            return food.foodNutrients
    //        } catch {
    //            print("Error decoding: \(error)")
    //            return nil
    //        }
    //    }


