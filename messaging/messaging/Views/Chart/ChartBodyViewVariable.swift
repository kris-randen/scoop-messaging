//
//  ChartBodyView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/26/23.
//

import SwiftUI

struct ChartBodyViewVariable: View {
    var chart: Chart
    var size: CGSize
    var orientation: Chart.Orientation
    var body: some View {
        HStack(alignment: .bottom) {
            AxisTitlesView(chart: chart)
//                .padding(.trailing, 10)
                .frame(width: size.width/3.5, alignment: .trailing)
                .multilineTextAlignment(.trailing)
            axis()
                .padding(.horizontal, 5)
                .foregroundColor(Colors.scoopRed)
            BarsView(chart: chart, size: size, orientation: orientation)
        }
    }
    
    fileprivate func axis() -> some View {
        FlexibleRoundedLine(orientation: .vertical, scaling: 0.97, width: 10)
            .frame(width: 15)
    }
}

#Preview {
    ChartBodyViewVariable(chart: Chart(profile: Profiles.carrot, kind: .macro), size: Constants.screen.size, orientation: .horizontal)
}
