//
//  WelcomeViewController.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 10.06.2024.
//

import UIKit
import CoreML

class WelcomeViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    let welcomeView = WelcomeView()
    let ingredientDetectionService = IngredientDetectionService()
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            let _ = RecipeService.shared.recipes
        }
        
        view.backgroundColor = .white
        setupActions()
    }
    
    // MARK: - Setup Methods
    private func setupActions() {
        welcomeView.takePictureButton.addTarget(self, action: #selector(takePictureTapped), for: .touchUpInside)
        let manualInputTapGesture = UITapGestureRecognizer(target: self, action: #selector(manualInputTapped))
        welcomeView.manualInputLabel.addGestureRecognizer(manualInputTapGesture)
        let favoritesTapGesture = UITapGestureRecognizer(target: self, action: #selector(favoritesTapped))
        welcomeView.favoritesLabel.addGestureRecognizer(favoritesTapGesture)
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
    
    @objc func favoritesTapped() {
        let favoriteRecipes = RecipeService.shared.recipes.filter { $0.isFavorite }
        let favoriteRecipesController = AllRecipesViewController(recipes: favoriteRecipes)
        navigationController?.pushViewController(favoriteRecipesController, animated: true)
    }
    
    // MARK: - Helper Methods
    private func performIngredientDetection(on image: UIImage) {
        ingredientDetectionService.performDetection(on: image) { [weak self] ingredients in
            guard let self = self else { return }
            print(ingredients)
            
            let ingredientsListController = IngredientsListViewController(ingredients: ingredients)
            self.navigationController?.pushViewController(ingredientsListController, animated: true)
        }
    }

}

extension WelcomeViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        performIngredientDetection(on: image)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

