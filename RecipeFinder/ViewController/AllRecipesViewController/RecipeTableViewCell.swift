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
    var cellImageView = UIImageView()
    
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
        contentView.addSubview(cellImageView)
        
        setupConstraints()
    }
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        
        nameLabel.text = recipe.name
        cellImageView.image = recipe.image
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        cellImageView.contentMode = .scaleAspectFit
        cellImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 60),
            cellImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
