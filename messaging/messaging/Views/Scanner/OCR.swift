//
//  OCR.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 12/20/23.
//

import Foundation
import Vision
import SwiftUI

/// A function that performs text recognition on the provided image.
func performOCR(on image: UIImage, completion: @escaping ([String]) -> Void) {
    ///Convert UIIMage to CGImage
    guard let cgImage = image.cgImage else {
        completion([])
        return
    }
    
    ///Create a new image-request handler.
    let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    
    ///Create a new request to recognize text.
    let request = VNRecognizeTextRequest { request, error in
        guard error == nil else {
            print("OCR error: \(error?.localizedDescription)")
            completion([])
            return
        }
        
        ///Process the results
        let textRecognitionResults = request.results as? [VNRecognizedTextObservation]
        let recognizedStrings = textRecognitionResults?.compactMap { observation in
            ///Return the top candidate's string
            observation.topCandidates(1).first?.string
        } ?? []
        
        completion(recognizedStrings)
    }
    
    ///Set recognition level and language
    request.recognitionLevel = .accurate // or .fast
    request.recognitionLanguages = ["en-US"]
    
    ///Perform the text-recognition request
    do {
        try requestHandler.perform([request])
    } catch {
        print("Unable to perform the requests: \(error.localizedDescription)")
        completion([])
    }
}
