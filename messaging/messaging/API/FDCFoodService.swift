//
//  FDCService.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/12/23.
//

import Foundation

struct FDCFoodService {
    let urlPrefix: String
    let apiKey: String
    private var cache = [String: NutrientProfile]()
    
    private func urlString(for foodItem: String) -> String {
        "\(urlPrefix)?query=\(foodItem)&api_key=\(apiKey)"
    }
    
    private func url(for foodItem: String) -> URL {
        URL(string: urlString(for: foodItem))!
    }
    
    init(apiKey: String = Constants.APIkeyFDC, urlPrefix: String = Constants.APIurlstringFDC) {
        self.apiKey = apiKey
        self.urlPrefix = urlPrefix
    }
    
    mutating func fetchNutritionInfo(for foodItem: String) async -> NutrientProfile {
        if let cached = retrieve(foodItem) { return cached }
        let profile = await fetchFromFDC(foodItem)
        save(profile, for: foodItem)
        return profile
    }
    
    private func fetchFromFDC(_ foodItem: String) async ->  NutrientProfile {
        await fetchProfile(for: foodItem)!
    }
    
    private func fetchProfile(for foodItem: String) async -> NutrientProfile? {
        do {
            let data = try await fetchDataUnhandled(for: foodItem)
            return FoodNutrientParser.extract(from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func retrieve(_ foodItem: String) -> NutrientProfile? { cache[foodItem] }
    
    private mutating func save(_ profile: NutrientProfile, for foodItem: String) {
        self.cache[foodItem] = profile
    }
    
    func fetchData(for foodItem: String) async -> Data? {
        do {
            print("Fetching in FDCFoodService food item: \(foodItem)")
            return try await fetchDataUnhandled(for: foodItem)
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchDataUnhandled(for foodItem: String) async throws -> Data {
        try await fetchDataAndResponse(for: foodItem).data
    }
    
    private func fetchDataAndResponse(for foodItem: String) async throws -> (data: Data, response: URLResponse) {
        try await URLSession.shared.data(from: url(for: foodItem))
    }
}
    
    
    
    
    
    
    
//    func fetchFDCfoodNutrientIntakes(for foodItem: String) async throws -> [FDCfoodNutrientIntake]? {
//        guard let url = fdcURL(for: foodItem) else { return nil }
//        let (data, _) = try await fetchData(from: url)
//        return try parseFoodNutrients(from: data)
//    }
//
//    func nutrientProfile(for foodItem: String) async throws -> NutrientProfile? {
//        do {
//            guard let fdcIntakes = try await fetchFDCfoodNutrientIntakes(for: foodItem) else { return nil }
//            return FDCUnits.nutrientProfile(from: fdcIntakes)
//        } catch {
//            print("error: \(error.localizedDescription)")
//            return nil
//        }
//    }
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


