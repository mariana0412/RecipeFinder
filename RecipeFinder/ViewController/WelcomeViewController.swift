//
//  WelcomeViewController.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 10.06.2024.
//

import Foundation
import UIKit
import Vision
import CoreML

class WelcomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to RecipeFinder!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please, take a picture of your products."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "products_on_the_table")
        return imageView
    }()
    
    let takePictureButton: UIButton = ButtonFactory.makeButton(withTitle: "Take Photo", imageName: "camera.fill")
    
    let manualInputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Proceed with manual input"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        return label
    }()

    lazy var coreMLRequest: VNCoreMLRequest? = {
        do {
            let model = try yolov8s(configuration: MLModelConfiguration()).model
            let vnCoreMLModel = try VNCoreMLModel(for: model)
            let request = VNCoreMLRequest(model: vnCoreMLModel)
            request.imageCropAndScaleOption = .scaleFill
            return request
        } catch let error {
            print("Failed to load model: \(error)")
            return nil
        }
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            RecipeService.shared.loadRecipes()
        }
        
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        view.addSubview(welcomeLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(productImageView)
        view.addSubview(takePictureButton)
        view.addSubview(manualInputLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            instructionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionsLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            productImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            productImageView.heightAnchor.constraint(equalToConstant: 320),
            takePictureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takePictureButton.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            manualInputLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            manualInputLabel.topAnchor.constraint(equalTo: takePictureButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupActions() {
        takePictureButton.addTarget(self, action: #selector(takePictureTapped), for: .touchUpInside)
        let manualInputTapGesture = UITapGestureRecognizer(target: self, action: #selector(manualInputTapped))
        manualInputLabel.addGestureRecognizer(manualInputTapGesture)
    }
    
    // MARK: - Action Methods
    @objc func takePictureTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Camera not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func manualInputTapped() {
        let ingredientsListController = IngredientsListViewController()
        navigationController?.pushViewController(ingredientsListController, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        performYOLODetection(on: image)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    private func performYOLODetection(on image: UIImage) {
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
            
            let ingredients = processResults(results: results)
            
            // Redirect to IngredientsListController
            let ingredientsListController = IngredientsListViewController(ingredients: ingredients)
            navigationController?.pushViewController(ingredientsListController, animated: true)
        } catch {
            print("Failed to perform VNImageRequestHandler: \(error)")
        }
    }
    
    private func processResults(results: [VNRecognizedObjectObservation], minConfidence: VNConfidence = 0.5) -> [Ingredient] {
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
