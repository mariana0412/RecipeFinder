//
//  RecipeViewController.swift
//  RecipeFinder
//
//  Created by Анастасія Грисюк on 09.06.2024.
//

import UIKit

class RecipeViewController: UIViewController {
    
    // MARK: - Properties
    let recipeView = RecipeView()
    var recipe: Recipe?
    weak var delegate: RecipeUpdateDelegate?
    
    // MARK: - Custom Initializer
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = recipeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")

        configureView()
        setupActions()
    }
    
    // MARK: - Helper Methods
    private func configureView() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "LabelsColor")
        
        guard let recipe = recipe else { return }
        recipeView.label.text = recipe.formattedName
        recipeView.recipeDescription.text = recipe.description
        recipeView.cookingTimeLabel.text = "\(recipe.minutes) minute(s)"
        recipeView.stepsTextView.text = recipe.steps.enumerated().map { "\($0 + 1). \($1)" }.joined(separator: "\n\n")
        recipeView.ingredients.text = recipe.ingredients.enumerated().map { $1 }.joined(separator: ", ")
        updateFavoriteButton()
    }
    
    private func setupActions() {
        recipeView.favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }
    
    @objc private func toggleFavorite() {
        recipe?.isFavorite.toggle()
        updateFavoriteButton()
        
        if let recipe = recipe {
            RecipeService.shared.updateRecipe(recipe)
            delegate?.didUpdateFavoriteStatus(for: recipe)
        }
    }
    
    private func updateFavoriteButton() {
        let imageName = recipe?.isFavorite == true ? "heart.fill" : "heart"
        recipeView.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
