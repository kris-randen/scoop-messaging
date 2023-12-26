//
//  FoodItemsListViewNew.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/23/23.
//

import SwiftUI

struct FoodItemsListViewNew: View {
    @StateObject var vm = FoodItemsListViewModel()
    @State var food: String = "carrot"
    @State var kind: Nutrient.Kind = .macro
    @State var quantity: String = ""
    @State var unit: Units.Mass = .gm
    
    @State var loading: Bool = false
    @State var navigate = false
    let allUnits: [String] = Units.Mass.allCases.map{$0.name} + Units.Volume.allCases.map{$0.name}
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Avenir Next Bold", size: 18)!, .foregroundColor: UIColor(Colors.scoopRed)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScoopTextField(
                    text: $food,
                    kind: $kind,
                    quantity: $quantity,
                    unit: $unit
                )
                ScoopButtonNew(vm: vm, food: food, navigate: $navigate)
                    .padding()
                if vm.isLoading {
                    GettingTheInsideScoopView(food: food)
                }
                if let profile = vm.profile {
                    NavigationLink("", destination: NutrientDetailView(kind: $kind, profile: profile), isActive: $navigate)
                }
            }
            .vStackify()
            .navigationInlinify(title: Constants.NavigationTitle.foodItem)
        }
        .ignoresSafeArea(.all, edges: .all)
        .accentColor(Colors.scoopRed)
    }
}

#Preview {
    FoodItemsListViewNew()
}
