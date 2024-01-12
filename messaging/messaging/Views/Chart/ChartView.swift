//
//  ChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/26/23.
//

import SwiftUI

struct ChartView: View {
    var chart: Chart
    var size: CGSize
    
    var body: some View {
        VStack {
            ChartTitleView(chart: chart)
            ChartBodyViewVariable(chart: chart, size: size, orientation: .horizontal)
            .chartFramify()
        }
    }
}

#Preview {
    ChartView(chart: Chart(profile: Profiles.arugula, kind: .vitamin), size: Constants.screen.size)
}
