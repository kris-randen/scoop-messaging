//
//  OCRResultsView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

struct OCRResultsView: View {
    var recognizedText: [String]
    
    var body: some View {
        List(recognizedText, id: \.self) { text in
            Text(text)
        }
    }
}

#Preview {
    OCRResultsView(recognizedText: ["Hello", "World"])
}
