//
//  ScoopButtonNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/23/23.
//

import SwiftUI

struct ScoopButtonNew: View {
    @ObservedObject var vm: FoodItemsListViewModel
    var food: String
    @Binding var navigate: Bool
    
    var body: some View {
        Button {
            Task {
                Task {
                    await vm.fetchNutritionInfo(for: food)
                    navigate = true
                }
            }
        } label: {
            ScoopButtonLabelView()
        }
    }
}

//#Preview {
//    ScoopButtonNew(food: "arugula", profile: .constant(Profiles.arugula), loading: .constant(false), navigate: .constant(false))
//}
