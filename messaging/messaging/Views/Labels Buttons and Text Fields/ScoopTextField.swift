//
//  ScoopTextField.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

struct ScoopTextField: View {
    var shape = Shapes.textField
    @Binding var text: String
    @Binding var kind: Nutrient.Kind
    @Binding var quantity: String
    @Binding var unit: Units.Mass

    let allUnits: [String] = Units.Mass.display.map{$0.name} + Units.Volume.display.map{$0.name}
    
    var body: some View {
        VStack {
            TextField(text: $text, prompt: Text("").foregroundColor(Colors.scoopRedPlaceholder)) {
                Text("Maggie...").foregroundColor(Colors.scoopRedPlaceholder)
            }
            .overlay(alignment: .trailing) {
                Button {
                    kind = kind.toggle()
                } label: {
                    BadgeView(badge: Badge(kind: .kind(kind: kind)))
                }
                .padding(.trailing, -45)
            }
            .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
            .font(Fonts.signInTextField)
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
            
            HStack {
                Text("serving")
                    .font(Fonts.badgeFont)
                    .padding(.trailing)
                TextField("100", text: $quantity)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .background(Color.white)
                    .borderify(shape: shape, color: Colors.scoopYellow)
                Button {
                    unit = unit.toggle()
                } label: {
                    BadgeView(badge: Badge(kind: .mass(unit: unit)))
                }
                .frame(width: 30)
                .padding(.leading)
            }
            .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
            .font(Fonts.signInTextField)
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
        }
        .foregroundColor(Colors.scoopRed)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
    }
}

#Preview {
    ScoopTextField(text: .constant(""), kind: .constant(.macro), quantity: .constant("100"), unit: .constant(.gm))
}
