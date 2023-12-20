//
//  ScoopButton.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

struct ScoopButton: View {
    var food: String
    @Binding var profile: NutrientProfile
    @Binding var loading: Bool
    @Binding var navigate: Bool
    
    var body: some View {
        Button {
            Task {
                loading = true
                var service = FDCFoodService()
                profile = await service.fetchNutritionInfo(for: food)
                loading = false
                navigate = true
            }
        } label: {
            ScoopButtonLabelView()
        }
    }
}

#Preview {
    ScoopButton(food: "arugula", profile: .constant(Profiles.arugula), loading: .constant(false), navigate: .constant(false))
}
