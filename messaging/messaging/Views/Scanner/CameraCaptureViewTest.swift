////
////  CameraCaptureViewTest.swift
////  messaging
////
////  Created by Krishnaswami Rajendren on 12/20/23.
////
//

import SwiftUI
import AVFoundation

struct CameraCaptureViewTest: View {
    @State private var isCameraActive = true
    @State private var capturedImage: UIImage?
    @State private var recognizedText: [String] = []
    @State private var showingOCRResults = false

    var body: some View {
        ZStack {
            if isCameraActive {
                CameraFeedView(isCameraActive: $isCameraActive, capturedImage: $capturedImage)
                    .edgesIgnoringSafeArea(.all)
            } else {
                
            }
            if let image = capturedImage {
                // Show the captured image with options for OCR and processing
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Button {
                    performOCR(on: image) { recognizedStrings in
                        self.recognizedText = recognizedStrings
                        self.showingOCRResults = true
                    }
                } label: {
                    Text("Perform OCR")
                }
                .padding()
                .background(Colors.scoopYellow)
                .foregroundColor(Colors.scoopRed)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                ///Navigation link to display OCR Results
                NavigationLink(
                    destination: OCRResultsView(recognizedText: recognizedText),
                    isActive: $showingOCRResults,
                    label: {
                        EmptyView()
                    })
            } else {
                ///Camera View
                CameraFeedView(isCameraActive: $isCameraActive, capturedImage: $capturedImage)
            }
        }
        .fullScreenCover(isPresented: $isCameraActive)  {
            CameraFeedView(isCameraActive: $isCameraActive, capturedImage: $capturedImage)
        .ignoresSafeArea()
        }
    }
}

struct CaptureButtonView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "camera.fill")
                .font(.largeTitle)
                .padding()
                .background(Colors.scoopYellow)
                .clipShape(Circle())
                .foregroundColor(Colors.scoopRed)
        }
        .padding(.bottom)
    }
}

// Placeholder for CameraFeedView - This will be replaced with the actual implementation using AVFoundation
//struct CameraFeedView: View {
//    @Binding var isActive: Bool
//    
//    var body: some View {
//        Color.black // This represents the camera feed
//    }
//}

struct SnapchatLikeCameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraCaptureViewTest()
    }
}

