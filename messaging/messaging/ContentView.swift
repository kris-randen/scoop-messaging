//
//  ContentView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        SignInView()
        HorizontalChartView(chart: Chart(profile: Profiles.boostHighProteinDrink, kind: .vitamin, nqi: -47)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        SignInView()
        HorizontalChartView(chart: Chart(profile: Profiles.boostHighProteinDrink, kind: .vitamin, nqi: -47)!)
    }
}
