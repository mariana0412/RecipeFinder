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
        label.textColor = UIColor(named: "LabelColor")
        return label
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please, take a picture of your products"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "LabelColor")
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
        label.textColor = UIColor(named: "ButtonColor")
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let favoritesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "View Favorite Recipes"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "ButtonColor")
        label.isUserInteractionEnabled = true
        return label
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
        addSubview(manualInputLabel)
        addSubview(favoritesLabel)
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
            manualInputLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            manualInputLabel.topAnchor.constraint(equalTo: takePictureButton.bottomAnchor, constant: 20),
            favoritesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoritesLabel.topAnchor.constraint(equalTo: manualInputLabel.bottomAnchor, constant: 20)
        ])
    }
}
