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
        
        configureView()
    }
    
    // MARK: - Helper Methods
    private func configureView() {
        guard let recipe = recipe else { return }
        recipeView.label.text = recipe.formattedName
        recipeView.recipeDescription.text = recipe.description
        recipeView.backgroundColor = .white
    }
}
