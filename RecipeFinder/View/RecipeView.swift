//
//  RecipeView.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 24.06.2024.
//

import UIKit

class RecipeView: UIView {
    
    // MARK: - Properties
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "LabelsColor")
        
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "LabelsColor")
        label.text = "Ingredients:"
        
        return label
    }()
    
    let ingredients: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "LabelsColor")
        
        return label
    }()
    
    let recipeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "LabelsColor")
        
        return label
    }()
    
    let timerIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "clock"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "LabelsColor")
        
        return imageView
    }()
    
    let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "LabelsColor")
        
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitleColor(UIColor(named: "LabelsColor"), for: .normal)
        button.tintColor = UIColor(named: "ButtonColor")
        
        return button
    }()
    
    let stepsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Steps:"
        label.textColor = UIColor(named: "LabelsColor")
        
        return label
    }()
    
    let stepsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textColor = UIColor(named: "LabelsColor")
        textView.backgroundColor = UIColor(named: "Background Color")
        
        return textView
    }()
    
    // MARK: - Custom Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = UIColor(named: "BackgroundColor")
        
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        addSubview(label)
        addSubview(recipeDescription)
        addSubview(timerIcon)
        addSubview(cookingTimeLabel)
        addSubview(favoriteButton)
        addSubview(stepsLabel)
        addSubview(stepsTextView)
        addSubview(ingredientsLabel)
        addSubview(ingredients)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 90),
            label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            timerIcon.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            timerIcon.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timerIcon.widthAnchor.constraint(equalToConstant: 24),
            timerIcon.heightAnchor.constraint(equalToConstant: 24),
            
            cookingTimeLabel.centerYAnchor.constraint(equalTo: timerIcon.centerYAnchor),
            cookingTimeLabel.leadingAnchor.constraint(equalTo: timerIcon.trailingAnchor, constant: 8),
            
            favoriteButton.centerYAnchor.constraint(equalTo: timerIcon.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            ingredientsLabel.topAnchor.constraint(equalTo: cookingTimeLabel.bottomAnchor, constant: 16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            ingredients.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 5),
            ingredients.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            ingredients.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            recipeDescription.topAnchor.constraint(equalTo: ingredients.bottomAnchor, constant: 20),
            recipeDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            recipeDescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            stepsLabel.topAnchor.constraint(equalTo: recipeDescription.bottomAnchor, constant: 20),
            stepsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            stepsTextView.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor, constant: 5),
            stepsTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stepsTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stepsTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
