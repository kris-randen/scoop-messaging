//
//  ScannerViewModel.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/21/23.
//

import Foundation
import AVKit
import VisionKit
import SwiftUI

enum ScanType: String 
{
    case barcode, text
}

enum DataScannerAccessStatusType
{
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
final class ScannerViewModel: ObservableObject
    ///Helps to reflect back the chnges made to the observed object by reloading the view
{
    @Published var dataScannerAccessStatusType: DataScannerAccessStatusType = .notDetermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .text
    @Published var scanTextType: DataScannerViewController.TextContentType?
    @Published var recognizedMultipleItem = true
    
    var recognizedDataType: DataScannerViewController.RecognizedDataType
    {
        scanType == .barcode ? .barcode() : .text(textContentType: scanTextType)
    }
    
    var headerText: String
    {
        if recognizedItems.isEmpty
        {
            return "Scanning \(scanType.rawValue)"
        }
        else
        {
            return "Recognized Items \(recognizedItems.count)"
        }
    }
    
    var dataScannerViewID: Int
    {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognizedMultipleItem)
        if let scanTextType
        {
            hasher.combine(scanTextType)
        }
        return hasher.finalize()
    }
    
    private var isScannerAvailable: Bool
    {
        DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }
    
    func requestDataScannerAccessStatus() async
    {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else
        {
            dataScannerAccessStatusType = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video)
        {
        case .authorized:
            dataScannerAccessStatusType = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
        case .restricted, .denied:
            dataScannerAccessStatusType = .cameraAccessNotGranted
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted
            {
                dataScannerAccessStatusType = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            }
            else 
            {
                dataScannerAccessStatusType = .cameraAccessNotGranted
            }
        default: break
        }
    }
}
