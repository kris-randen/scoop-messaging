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
import AVFoundation
//import CodeScanner

struct ScannerContentView: View
{
    @EnvironmentObject var vm: ScannerViewModel
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] =
    [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]
    
    var body: some View
    {
        switch vm.dataScannerAccessStatusType {
        case .scannerAvailable:
            mainView
        case .notDetermined:
            Text("Requesting camera access")
                .onAppear {
                    requestCameraAccess()
                }
        case .cameraAccessNotGranted:
            Text("Pleae provide access to the camera in settings")
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerNotAvailable:
            Text("Your device doesn't have suppport for scanning barcode with this app")
        }
    }
    
    private func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                vm.dataScannerAccessStatusType = granted ? .scannerAvailable : .cameraAccessNotGranted
            }
        }
    }
    
    private var mainView: some View
    {
        ZStack {
            DataScannerView(
                recognizedItems: $vm.recognizedItems,
                recognizedDataType: vm.recognizedDataType,
                scanMultiple: vm.recognizedMultipleItem
            )
            .background {Color.gray.opacity(0.3)}
            .ignoresSafeArea()
            .id(vm.dataScannerViewID)
            .onChange(of: vm.scanType) {_ in vm.recognizedItems = []}
            .onChange(of: vm.scanTextType) {_ in vm.recognizedItems = []}
            .onChange(of: vm.recognizedMultipleItem) {_ in vm.recognizedItems = []}
            //        .sheet(isPresented: .constant(true))
            //        {
            VStack {
                Spacer()
                bottomContainerView
                    .background(.ultraThinMaterial)
                    .presentationDetents([.medium, .fraction(0.25)])
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
                //            .onAppear {
                //                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                //                          let controller  = windowScene.windows.first?.rootViewController?.presentedViewController else {
                //                        return
                //                    }
                //                    controller.view.backgroundColor = .clear
                //                }
                //        }
                //        .onChange(of: vm.scanType) {_ in vm.recognizedItems = []}
                //        .onChange(of: vm.scanTextType) {_ in vm.recognizedItems = []}
                //        .onChange(of: vm.recognizedMultipleItem) {_ in vm.recognizedItems = []
            }
        }
    }
    
    private var headerView: some View
    {
        VStack {
            HStack {
                Picker("Scan Type", selection: $vm.scanType) {
                    Text("Barcode").tag(ScanType.barcode)
                    Text("Text").tag(ScanType.text)
                }
                .pickerStyle(.segmented)
                Toggle("Scan Multiple", isOn: $vm.recognizedMultipleItem)
            }
            .padding(.top)
            
            if vm.scanType == .text
            {
                Picker("Text Content Type", selection: $vm.scanType) {
                    ForEach(textContentTypes, id: \.self.textContentType) { option in
                        Text(option.title).tag(option.textContentType)
                    }
                }
                .pickerStyle(.segmented)
            }
            Text(vm.headerText).padding(.top)
        }
        .padding(.horizontal)
    }
    
    private var bottomContainerView: some View
    {
        VStack {
            headerView
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(vm.recognizedItems) { item in
                        switch item
                        {
                        case .barcode(let barcode):
                            Text(barcode.payloadStringValue ?? "Unknown Barcode")
                        case .text(let text):
                            Text(text.transcript)
                        @unknown default:
                            Text("Unknown")
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ScannerContentView()
}
