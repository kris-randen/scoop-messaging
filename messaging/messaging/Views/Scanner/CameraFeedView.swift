//
//  CameraFeedView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import SwiftUI
import AVFoundation

struct CameraFeedView: UIViewControllerRepresentable {
    @Binding var isCameraActive: Bool
    @Binding var capturedImage: UIImage?
    
    class Coordinator: NSObject {
        let cameraManager = CameraManager()
        var parent: CameraFeedView
        
        init(_ parent: CameraFeedView) {
            self.parent = parent
        }
        
        @objc func captureButtonTapped() {
            cameraManager.captureImage { image in
                DispatchQueue.main.async {
                    self.parent.capturedImage = image
                    self.parent.isCameraActive = false
                }
            }
        }
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        setupCameraSession(viewController, context: context)
        addCaptureButton(viewController, context: context)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        context.coordinator.cameraManager.startSession()
    }
    
    static func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: Coordinator) {
        coordinator.cameraManager.stopSession()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    private func setupCameraSession(_ viewController: UIViewController, context: Context) {
        let coordinator = context.coordinator
        let cameraManager = coordinator.cameraManager
        cameraManager.checkPermissions()
        cameraManager.configureSession()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: cameraManager.session)
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        cameraManager.startSession()
    }
    
    ///Add capture button
    private func addCaptureButton(_ viewController: UIViewController, context: Context) {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
//        button.addTarget(context.coordinator, action: #selector(Coordinator.captureButtonTapped), for: .touchUpInside)
        // Style the button as needed
        
        let captureButton = UIButton(frame: CGRect(
            x: viewController.view.bounds.midX - 35,
            y: viewController.view.bounds.maxY - 80,
            width: 70,
            height: 70
        ))
        captureButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        captureButton.tintColor = .white
        captureButton.backgroundColor = .black
        captureButton.layer.cornerRadius = 35
        captureButton.layer.masksToBounds = true
        captureButton.addTarget(context.coordinator, action: #selector(Coordinator.captureButtonTapped), for: .touchUpInside)
        
        viewController.view.addSubview(captureButton)
        // Set up constraints or frame for the button as needed
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -20),
            captureButton.widthAnchor.constraint(equalToConstant: 70),
            captureButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    
}


#Preview {
    CameraFeedView(isCameraActive: .constant(true), capturedImage: .constant(UIImage(systemName: "Photo")))
}
