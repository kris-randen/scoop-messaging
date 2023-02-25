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
        FoodItemsListView()
//        HorizontalChartView(profile: .constant("boost high protein drink"), kind: .constant(.mineral))
//        VerticalChartView(chart: Chart(profile: Profiles.boostHighProteinDrink, kind: .macro, nqi: -47)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        SignInView()
        FoodItemsListView()
//        HorizontalChartView(profile: .constant("boost high protein drink"), kind: .constant(.mineral))
//        RoundedRectCaps(line: RoundedRect(x: 100, y: 100, width: 400, height: 40, radiusScaling: 0.3))
//        VerticalChartView(chart: Chart(profile: Profiles.boostHighProteinDrink, kind: .macro, nqi: -47)!)
    }
}
