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
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .font(Fonts.signInTextField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
    }
}
