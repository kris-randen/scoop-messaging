////
////  ScoopTextField.swift
////  messaging
////
////  Created by Krishnaswami Rajendren on 12/20/23.
////
//
//import SwiftUI


import SwiftUI

struct ScoopTextField: View {
    var shape = Shapes.textField
    @Binding var text: String
    @Binding var kind: Nutrient.Kind
    
    var body: some View {
        TextField(text: $text, prompt: Text("")
            .foregroundColor(Colors.scoopRedPlaceholder)) {
            Text("Maggie...")
                    .foregroundColor(Colors.scoopRedPlaceholder)
        }
//        .overlay(alignment: .trailing) {
//            Button {
//                kind = kind.toggle()
//            } label: {
//                BadgeView(badge: Badge(kind: .kind(kind: kind)))
//            }
//            .padding(.trailing, -45)
//        }
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
    }
}
