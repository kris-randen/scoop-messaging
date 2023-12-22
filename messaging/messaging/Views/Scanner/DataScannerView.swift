//
//  DataScannerView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/21/23.
//

import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable 
{
    // A binding to update the parent view with the recognized text
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let scanMultiple: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(recognizedDataTypes: [recognizedDataType], qualityLevel: .balanced, recognizesMultipleItems: scanMultiple, isGuidanceEnabled: true, isHighlightingEnabled: true)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        // Update the view controller if needed
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }

    // Coordinator for handling delegate callbacks
    class Coordinator: NSObject, DataScannerViewControllerDelegate 
    {
        @Binding var recognizedItems: [RecognizedItem]

        init(recognizedItems: Binding<[RecognizedItem]>) {
            self._recognizedItems = recognizedItems
        }

        // Delegate method to handle recognized text
        func dataScannerDidZoom(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("Tap")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            print("ALL add")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recognizedItems = recognizedItems.filter { item in
                !removedItems.contains(where: {$0.id == item.id})
                
            }
            print("Deleted")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("Unavailable: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    DataScannerView(recognizedText: .constant("Hello"))
//}
