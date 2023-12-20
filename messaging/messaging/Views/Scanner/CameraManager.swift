//
//  CameraManager.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import AVFoundation
import UIKit

class CameraManager: NSObject {
    let session = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sessionQueue = DispatchQueue(label: "cameraSessionQueue")
    private let photoOutput = AVCapturePhotoOutput()
    private var imageCaptureCompletion: ((UIImage?) -> Void)?

    var previewLayer: AVCaptureVideoPreviewLayer?

    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUpSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setUpSession()
                }
            }
        default:
            // Handle denied access
            break
        }
    }

    private func setUpSession() {
        sessionQueue.async {
            self.configureSession()
        }
        
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
    }
    
    func captureImage(completion: @escaping (UIImage?) -> Void) {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
        self.imageCaptureCompletion = completion
    }

    func configureSession() {
        session.beginConfiguration()

        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)

        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else { return }

        session.addInput(videoDeviceInput)

        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }

        session.commitConfiguration()
    }

    func startSession() {
        sessionQueue.async {
            self.session.startRunning()
        }
    }

    func stopSession() {
        sessionQueue.async {
            self.session.stopRunning()
        }
    }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error: \(error)")
            imageCaptureCompletion?(nil)
        } else if let data = photo.fileDataRepresentation(),
                  let image = UIImage(data: data) {
            imageCaptureCompletion?(image)
        } else {
            imageCaptureCompletion?(nil)
        }
    }
}
