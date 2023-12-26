//
//  ItemDescriptionView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

struct ItemDescriptionView: View {
    var food: String
    var nqi: Double
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack {
                Text("\(food) 🕵🏻")
                    .font(Fonts.Card.food.weight(.bold))
                HStack {
//                    Text("**NQI** = \(Int(nqi))")
//                        .font(Fonts.Card.food.weight(.regular))
                    Text("**NQI** = NA")
                        .font(Fonts.Card.food.weight(.regular))
//                    BadgeView(badge: Badge(kind: .food, nqi: Int(nqi)))
                }
            }
            .multilineTextAlignment(.center)
            .padding(.top)
            .padding(.horizontal)
        }
    }
}
