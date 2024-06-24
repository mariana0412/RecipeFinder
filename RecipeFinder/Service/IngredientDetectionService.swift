//
//  IngredientDetectionService.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 24.06.2024.
//

import Foundation
import Vision
import CoreML
import UIKit

class IngredientDetectionService {
    private lazy var coreMLRequest: VNCoreMLRequest? = {
        do {
            let model = try RecipeFinder(configuration: MLModelConfiguration()).model
            let vnCoreMLModel = try VNCoreMLModel(for: model)
            let request = VNCoreMLRequest(model: vnCoreMLModel)
            request.imageCropAndScaleOption = .scaleFill
            return request
        } catch let error {
            print("Failed to load model: \(error)")
            return nil
        }
    }()
    
    func performDetection(on image: UIImage, completion: @escaping ([Ingredient]) -> Void) {
        guard let coreMLRequest = coreMLRequest else {
            print("Failed to create VNCoreMLRequest")
            return
        }
        
        guard let ciImage = CIImage(image: image) else {
            print("Failed to create CIImage")
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        do {
            try handler.perform([coreMLRequest])
            
            guard let results = coreMLRequest.results as? [VNRecognizedObjectObservation] else {
                print("Failed to get results from VNCoreMLRequest")
                return
            }
            
            let ingredients = self.processResults(results: results)
            completion(ingredients)
        } catch {
            print("Failed to perform VNImageRequestHandler: \(error)")
        }
    }
    
    private func processResults(results: [VNRecognizedObjectObservation], minConfidence: VNConfidence = 0.1) -> [Ingredient] {
        var detectedObjects: [String: VNConfidence] = [:]
        var ingredients: [Ingredient] = []
        
        for result in results {
            let confidence = result.confidence
            guard confidence >= minConfidence else { continue }
            
            if let label = result.labels.first?.identifier {
                if let existingConfidence = detectedObjects[label], existingConfidence >= confidence {
                    continue
                }
                detectedObjects[label] = confidence
                ingredients.append(Ingredient(name: label))
            }
        }
        
        for (label, confidence) in detectedObjects {
            print("Object: \(label), Confidence: \(confidence)")
        }
        
        return ingredients
    }
}
