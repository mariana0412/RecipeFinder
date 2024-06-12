//
//  RecipeViewController.swift
//  RecipeFinder
//
//  Created by Анастасія Грисюк on 09.06.2024.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var recipe: Recipe?
    var label = UILabel()
    
    var recipeDescription = UILabel()
    var imageView = UIImageView()
    
    
    init(recipe: Recipe) {
        self.recipe = recipe
        label.text = recipe.name
        //description todo
        imageView.image = recipe.image
        recipeDescription.text = ("lorem ilorem ipsum lorem ipsumlorem ipsumlorem ipsum   lorem ipsumlorem ipsum  lorem ipsumpsumlorem ipsum lorem ipsum")
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
        
        print(recipe?.name)
    }
    
    func layoutViews() {
        recipeDescription.numberOfLines = 0
        view.addSubview(label)
        view.addSubview(recipeDescription)
        view.addSubview(imageView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        recipeDescription.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            recipeDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeDescription.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            recipeDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            recipeDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

#Preview {
    RecipeViewController(recipe: Recipe(name: "nastia sweet"))
}
