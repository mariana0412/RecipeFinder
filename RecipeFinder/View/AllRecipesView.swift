//
//  AllRecipesView.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 24.06.2024.
//

import UIKit

class AllRecipesView: UIView {
    
    // MARK: - Properties
    let recipesTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return tableView
    }()
    
    // MARK: - Custom Initializer
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
        addSubview(recipesTable)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipesTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            recipesTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            recipesTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            recipesTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -0),
        ])
    }
}
