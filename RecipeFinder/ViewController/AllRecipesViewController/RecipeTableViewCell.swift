//
//  RecipeTableViewCell.swift
//  RecipeFinder
//
//  Created by Анастасія Грисюк on 09.06.2024.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    static let identifier = "RecipeCell"
    
    var recipe: Recipe?
    var nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(nameLabel)
        setupConstraints()
        setupAppearance()
    }
    
    func configure(with recipe: Recipe) {
        self.backgroundColor = UIColor(named: "BackgroundColor")
        self.accessoryType = .disclosureIndicator
        self.recipe = recipe
        nameLabel.text = recipe.formattedName
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupAppearance() {
        nameLabel.textColor = UIColor(named: "LabelsColor")
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
}
