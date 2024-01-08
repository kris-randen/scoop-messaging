//
//  ChartTitleViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 1/5/24.
//

import SwiftUI

struct ChartTitleViewNew: View {
    var chart: Chart
    @Binding var kind: Nutrient.Kind
    @Binding var serving: Serving.Kind
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            Button {
                serving = serving.toggle()
            } label: {
                BadgeView(badge: Badge(kind: .serving(kind: serving)))
            }
            Spacer()
            Button {
                kind = kind.toggle()
            } label: {
                BadgeView(badge: Badge(kind: .kind(kind: kind)))
            }
            Spacer()
        }
    }
}

#Preview {
    ChartTitleViewNew(chart: Chart(profile: Profiles.arugula, kind: .vitamin), kind: .constant(.vitamin), serving: .constant(.kcal2000))
}
