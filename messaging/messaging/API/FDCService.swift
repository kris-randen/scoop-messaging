//
//  FDCService.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 3/2/23.
//

import Foundation

struct FDCService {
    static func fetchFoodItem(query: String) async throws -> FDCFoodItem {
        guard let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=DEMO_KEY&query=\(query)") else {
            throw USDAError.invalidResponse
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Http Response failure with status")
            throw USDAError.invalidResponse
        }
        
        print("HTTP Status = \(httpResponse.statusCode)")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        
        do {
            let result = try decoder.decode(FDCResponse.self, from: data)
            guard let foodItem = result.foods.first else {
                throw USDAError.decodingError
            }
            print("description = \(foodItem.description)")
            for nutrient in foodItem.foodNutrients {
                if nutrient.value != 0 {
                    print("nutrient = \(nutrient.value)")
                }
            }
            return foodItem
        } catch {
            print("Decoding error = \(USDAError.decodingError.localizedDescription)")
            throw USDAError.decodingError
        }
    }
}
