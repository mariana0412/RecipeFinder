//
//  WelcomeViewController.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 10.06.2024.
//

import Foundation
import UIKit

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
    
    let takePictureButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = " Take Photo"
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .systemYellow
        configuration.cornerStyle = .medium
        configuration.image = UIImage(systemName: "camera.fill")
        configuration.imagePadding = 10
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        configuration.attributedTitle = AttributedString(" Take Photo", attributes: container)
        
        button.configuration = configuration
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        view.addSubview(welcomeLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(productImageView)
        view.addSubview(takePictureButton)
        takePictureButton.addTarget(self, action: #selector(takePictureTapped), for: .touchUpInside)
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
            takePictureButton.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10)
        ])
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
        // YOLO detection
        
        // Redirect to IngredientsListController
        let ingredientsListController = IngredientsListViewController()
        ingredientsListController.ingredients = [Ingredient(name: "Sample Ingredient 1"), Ingredient(name: "Sample Ingredient 2")]
        navigationController?.pushViewController(ingredientsListController, animated: true)
    }
    
}
