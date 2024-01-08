////
////  FoodItemsListView.swift
////  messaging
////
////  Created by Krishnaswami Rajendren on 10/23/22.
////
//
//import SwiftUI
//
//struct FoodItemsListViewOld: View {
//    @State var food: String = "carrot"
//    @State var kind: Nutrient.Kind = .macro
//    @State var quantity: String = ""
//    @State var unit: Units.Mass = .gm
//    
//    @State var profile: NutrientProfile = Profiles.carrot
//    @State var loading: Bool = false
//    @State var navigate = false
//    let allUnits: [String] = Units.Mass.allCases.map{$0.name} + Units.Volume.allCases.map{$0.name}
//    
//    init() {
//        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Avenir Next Bold", size: 18)!, .foregroundColor: UIColor(Colors.scoopRed)]
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                ScoopTextField(
//                    text: $food,
//                    kind: $kind,
//                    quantity: $quantity,
//                    unit: $unit
//                )
//                ScoopButton(
//                    food: food,
//                    profile: $profile,
//                    loading: $loading,
//                    navigate: $navigate
//                )
//                .padding()
//                if loading {
//                    GettingTheInsideScoopView(food: food)
//                }
//                NavigationLink("", destination: NutrientDetailViewVariable(kind: $kind, profile: profile), isActive: $navigate)
//            }
//            .vStackify()
//            .navigationInlinify(title: Constants.NavigationTitle.foodItem)
//        }
//        .ignoresSafeArea(.all, edges: .all)
//        .accentColor(Colors.scoopRed)
//    }
//}
//
//struct FoodItemsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodItemsListViewOld()
//    }
//}
