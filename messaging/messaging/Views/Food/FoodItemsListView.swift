//
//  FoodItemsListView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/23/22.
//

import SwiftUI

struct FoodItemsListView: View {
    //    @State var text: String = "boost high protein drink"
    @State var text: String = "arugula"
    @State var kind: Nutrients.Kind = .macro
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Avenir Next Bold", size: 18)!, .foregroundColor: UIColor(Colors.scoopRed)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                loginTextField()
                NavigationLink {
                    if valid(item: text) {
                        switch kind {
                        case .macro:
                            VerticalChartView(profile: text, kind: $kind)
                        default:
                            HorizontalChartView(profileName: text, kind: $kind)
                        }
                    }
                } label: {
                    signInButtonLabel()
                }
                .ignoresSafeArea(.keyboard)
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Food Item")
        }
        .accentColor(Colors.scoopRed)
    }
    
    fileprivate func valid(item name: String) -> Bool {
        Profiles.dict.contains{$0.key == name}
    }
    
    fileprivate func signInButton() -> some View {
        Button {
            //
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
        .disableAutocorrection(true)
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
