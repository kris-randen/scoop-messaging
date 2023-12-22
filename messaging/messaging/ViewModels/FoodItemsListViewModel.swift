//
//  FoodItemsListViewModel.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/17/23.
//

import SwiftUI
import Foundation

class FoodItemsListViewModel: ObservableObject {
    //MARK: - Published properties that FoodItemsListView can bind to
    @Published var foodItems: [FDCFood] = []
    @Published var isLoading: Bool = false
    @Published var nutrientProfile: NutrientProfile?
    
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
