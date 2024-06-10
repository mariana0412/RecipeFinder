//
//  WelcomeViewController.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 10.06.2024.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(welcomeLabel)
        view.addSubview(productImageView)
        view.addSubview(takePictureButton)
        
        setupConstraints()
    }
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Take a picture of your products, please"
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
        button.setTitle("Take Picture", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(WelcomeViewController.self, action: #selector(takePictureTapped), for: .touchUpInside)
        
        return button
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            productImageView.widthAnchor.constraint(equalToConstant: 350),
            productImageView.heightAnchor.constraint(equalToConstant: 350),
            
            takePictureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takePictureButton.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20)
        ])
    }
    
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
    
    private func performYOLODetection(on image: UIImage) {
        // YOLO detection
        
        // Redirect to IngredientsListController
        let ingredientsListController = IngredientsListViewController()
        ingredientsListController.ingredients = [Ingredient(name: "Sample Ingredient 1"), Ingredient(name: "Sample Ingredient 2")]
        navigationController?.pushViewController(ingredientsListController, animated: true)
    }
    
}
