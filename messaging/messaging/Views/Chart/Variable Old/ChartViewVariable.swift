//
//  ChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

struct ChartViewVariable: View {
    var orientation: Chart.Orientation = .vertical
    var chart: Chart
    var size: CGSize
    
    var body: some View {
        VStack {
            ChartTitleView(chart: chart)
            if orientation == .vertical {
                Spacer()
            }
            ChartBodyViewVariable(chart: chart, size: size, orientation: orientation)
            .chartFramifyVariable(for: orientation)
            .rotatify(for: orientation)
        }
    }
}

#Preview {
    ChartViewVariable(chart: Chart(profile: Profiles.arugula, kind: .macro), size: CGSize(width: Dimensions.Width, height: Dimensions.Height))
}
