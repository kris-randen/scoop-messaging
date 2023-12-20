//
//  ScannerContentView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/21/23.
//

//
//  ContentView.swift
//  scoop-app
//
//  Created by Krishnaswami Rajendren on 7/22/22.
//

import SwiftUI
import VisionKit
//import CodeScanner

struct ScannerContentView: View {
    @State private var recognizedText = ""

    var body: some View {
        VStack {
            DataScannerView(recognizedText: $recognizedText)
                .edgesIgnoringSafeArea(.all) // To use the full screen for the scanner

            // Displaying the recognized text
            Text("Recognized Text: \(recognizedText)")
                .padding()
        }
    }
}

#Preview {
    ScannerContentView()
}
