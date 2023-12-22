//
//  ScoopTabView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/21/23.
//

import SwiftUI

struct ScoopTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                FoodItemsListView()
            }
            .tabItem {
                Label("Scoop", image: "magnifyingglass")
            }
            NavigationView {
                ScannerContentView()
                    .environmentObject(ScannerViewModel())
            }
            .tabItem {
                Label("Scan", image: "camera")
            }
        }
    }
}

#Preview {
    ScoopTabView()
}
