//
//  FoodItemsListViewModel.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import SwiftUI
import Foundation

class FoodItemsListViewModel: ObservableObject {
    @Published var nutrientProfile: NutrientProfile?
    @Published var isLoading = false
    let fdcFoodService: FDCFoodService
    
    init(fdcFoodService: FDCFoodService = FDCFoodService()) {
        self.fdcFoodService = fdcFoodService
    }
    
    func fetchNutrientProfile(for foodItem: String) async {
        print("Fetching in View Model food item: \(foodItem)")
        DispatchQueue.main.async {
            self.isLoading = true
            print("Fetching in View Model food item: \(foodItem)")
        }
        
        do {
            let data = try await fdcFoodService.fetchDataUnhandled(for: foodItem)
            
            DispatchQueue.main.async {
                self.nutrientProfile = FoodNutrientParser.extract(from: data)
                self.isLoading = false
            }
        } catch {
            print("Error fetching data: \(error)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
