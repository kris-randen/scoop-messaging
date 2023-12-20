//
//  CameraCaptureView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI

struct CameraCaptureView: View {
    @State private var isCameraPresented = false
    @State private var capturedImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Button {
                    // Trigger OCR and processing here
                } label: {
                    ScoopButtonLabelView(name: "Scoop")
                }
                .padding()
            } else {
                Button {
                    isCameraPresented = true
                } label: {
                    ScoopButtonLabelView(name: "Capture")
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $isCameraPresented) {
            CameraView(isPresented: $isCameraPresented, image: $capturedImage)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    CameraCaptureView()
}
