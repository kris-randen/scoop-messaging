//
//  FDCresponse.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 3/2/23.
//

import Foundation

struct FDCNutrient: Decodable {
    let nutrientId: Int
    let nutrientName: String
    let nutrientNumber: String
    let unitName: String
    let value: Double
}

struct FDCResponse: Decodable {
    let foods: [FDCFoodItem]
}

struct FDCFoodItem: Decodable {
    let description: String
    let foodCategory: String
    let fdcId: String
    let servingSize: String
    let servingSizeUnit: String
    let gtinUpc: String
    let brandOwner: String?
    let ingredients: String?
    let foodNutrients: [FDCNutrient]

    let score: Int?
    let packageWeight: String?
    let publishedDate: String?
}

enum USDAError: Error {
    case invalidResponse
    case decodingError
    case networkError(Error)
}
