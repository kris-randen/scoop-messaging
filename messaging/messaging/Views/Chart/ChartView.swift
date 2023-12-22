//
//  ChartView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/22/23.
//

import SwiftUI

struct ChartView: View {
    var orientation: Chart.Orientation = .vertical
    var chart: Chart
    var size: CGSize
    
    var body: some View {
        VStack {
            ChartTitleView(chart: chart)
            if orientation == .vertical {
                Spacer()
            }
            HStack(alignment: .bottom) {
                AxisTitlesView(chart: chart)
                    .padding(.leading, 10)
                    .frame(width: size.width/3.5, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                axis()
                    .padding(.horizontal, 5)
                    .foregroundColor(Colors.scoopRed)
                BarsView(chart: chart, size: size, orientation: orientation)
            }
            .framify(for: orientation)
            .rotatify(for: orientation)
        }
    }
    
    fileprivate func axis() -> some View {
        FlexibleRoundedLine(orientation: .vertical, scaling: 0.97, width: 10)
            .frame(width: 15)
    }
}

#Preview {
    ChartView(chart: Chart(profile: Profiles.arugula, kind: .macro), size: CGSize(width: Dimensions.Width, height: Dimensions.Height))
}
