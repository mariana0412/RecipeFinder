//
//  WelcomeView.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 24.06.2024.
//

import UIKit

class WelcomeView: UIView {
    
    // MARK: - Properties
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to RecipeFinder!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor(named: "LabelsColors")
        return label
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please, take a picture of your products"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "LabelsColor")
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
    
    let manualInputButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Proceed with manual input", for: .normal)
        button.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        return button
    }()
    
    let favoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View Favorite Recipes", for: .normal)
        button.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        return button
    }()
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        addSubview(welcomeLabel)
        addSubview(instructionsLabel)
        addSubview(productImageView)
        addSubview(takePictureButton)
        addSubview(manualInputButton)
        addSubview(favoritesButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            instructionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            instructionsLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            productImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            productImageView.heightAnchor.constraint(equalToConstant: 320),
            takePictureButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            takePictureButton.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            manualInputButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            manualInputButton.topAnchor.constraint(equalTo: takePictureButton.bottomAnchor, constant: 20),
            favoritesButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoritesButton.topAnchor.constraint(equalTo: manualInputButton.bottomAnchor, constant: 20)
        ])
    }
}
