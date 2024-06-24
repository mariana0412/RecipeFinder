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
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LabelsColor")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
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
        label.preferredMaxLayoutWidth = 100
        
        return label
    }()
    
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
        contentView.addSubview(timerIcon)
        contentView.addSubview(cookingTimeLabel)
        
        setupConstraints()
        setupAppearance()
    }
    
    func configure(with recipe: Recipe) {
        self.backgroundColor = UIColor(named: "BackgroundColor")
        self.accessoryType = .disclosureIndicator
        
        self.recipe = recipe
        nameLabel.text = recipe.formattedName
        cookingTimeLabel.text = String(recipe.minutes)
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        timerIcon.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        timerIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        timerIcon.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        cookingTimeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        cookingTimeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            cookingTimeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            cookingTimeLabel.trailingAnchor.constraint(equalTo: timerIcon.leadingAnchor, constant: -5),
            cookingTimeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timerIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            timerIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    private func setupAppearance() {
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
}
