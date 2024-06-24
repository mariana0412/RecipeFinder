//
//  IngredientTableViewCell.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 10.06.2024.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    var ingredientNameChanged: ((String) -> Void)?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        contentView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupActions() {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Action Methods
    @objc private func textFieldDidChange() {
        ingredientNameChanged?(textField.text ?? "")
    }
    
    // MARK: - Configuration
    func configure(ingredient: String, ingredientNameChanged: @escaping (String) -> Void) {
        textField.text = ingredient
        self.ingredientNameChanged = ingredientNameChanged
    }
}
