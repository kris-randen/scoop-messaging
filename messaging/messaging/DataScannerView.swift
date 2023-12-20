//
//  DataScannerView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/21/23.
//

import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    // A binding to update the parent view with the recognized text
    @Binding var recognizedText: String

    // Coordinator for handling delegate callbacks
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScannerView

        init(_ parent: DataScannerView) {
            self.parent = parent
        }

        // Delegate method to handle recognized text
        func dataScanner(_ dataScanner: DataScannerViewController, didRecognizeText text: String) {
            parent.recognizedText = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scannerViewController = DataScannerViewController()
        scannerViewController.delegate = context.coordinator
        // Configure other properties if needed
        return scannerViewController
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        // Update the view controller if needed
    }
}

#Preview {
    DataScannerView(recognizedText: .constant("Hello"))
}
