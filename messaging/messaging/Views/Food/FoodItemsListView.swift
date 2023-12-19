//
//  FoodItemsListView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

struct FoodItemsListView: View {
    @StateObject var viewModel = FoodItemsListViewModel()
    @State var text: String = "broccoli raw"
    @State var kind: Nutrient.Kind = .macro
    @State var profile: NutrientProfile? = Profiles.carrot
    @State private var nutritionalInfo: String = "Nutritional Info will appear here"
    @State private var shouldNavigate = false
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Avenir Next Bold", size: 18)!, .foregroundColor: UIColor(Colors.scoopRed)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                loginTextField()
                Button(action: {
                    Task {
                        profile = await fetchNutritionInfo(for: text)
                        shouldNavigate = true
                    }
                }, label: {
                    signInButtonLabel()
                })
                .padding()
                if viewModel.isLoading {
                    ProgressView()
                }
                NavigationLink("", destination: chartView(), isActive: $shouldNavigate)
            }
            .ignoresSafeArea(.keyboard)
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Food Item")
        }
        .accentColor(Colors.scoopRed)
    }
    
    private func fetchNutritionInfo(for foodItem: String) async -> NutrientProfile {
        var service = FDCFoodService()
        return await service.fetchNutritionInfo(for: foodItem)
    }
    
    private func fetchProfile() {
        print("Button pressed.")
        Task {
            await viewModel.fetchNutrientProfile(for: text)
        }
    }
    
    @ViewBuilder
    private func chartView() -> some View {
        switch kind {
        case .macro:
            VerticalChartViewFDCapiTest(kind: $kind, nutrientProfile: profile!)
        default:
            HorizontalChartViewFDCapiTest(kind: $kind, profile: profile!)
        }
    }
    
    fileprivate func valid(item name: String) -> Bool {
        Profiles.dict.contains{$0.key == name}
    }
    
    fileprivate func signInButton() -> some View {
        Button {
            Task {
                await viewModel.fetchNutrientProfile(for: text)
            }
        } label: {
            signInButtonLabel()
        }
    }
    
    fileprivate func signInButtonLabel(with shape: Modifiers.Shapes = Shapes.textField) -> some View {
        Text("Scoop")
            .foregroundColor(Colors.scoopRed)
            .font(Fonts.fullWidthButtonLabel)
            .fullYellowButtonify(height: .height(scaling: Dimensions.HeightScaling.button, tolerance: 0))
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
    }
    
    fileprivate func loginTextField(with shape: Modifiers.Shapes = Shapes.textField) -> some View {
        TextField(text: $text, prompt: Text("Maggi Noodles...").foregroundColor(Colors.scoopRedPlaceholder)) {
            Text("").foregroundColor(Colors.scoopRedPlaceholder)
        }
        .foregroundColor(Colors.scoopRed)
        //        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
        .overlay(alignment: .trailing) {
            Button {
                kind = kind.toggle()
            } label: {
                BadgeView(badge: Badge(kind: .other(kind: kind), nqi: -47))
            }
            .padding(.trailing, -25)
        }
    }
}

struct FoodItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemsListView()
    }
}
