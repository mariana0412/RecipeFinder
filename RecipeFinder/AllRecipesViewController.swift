//
//  AllRecipesViewController.swift
//  RecipeFinder
//
//  Created by Анастасія Грисюк on 09.06.2024.
//

import UIKit
import SwiftUI


class AllRecipesViewController: UIViewController {
    
    var recipes: [Recipe] = [Recipe(name: "lalala", image: UIImage(named: "framex") ?? nil)]
    
    var recipesTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
    }
    
    private func setUpTable() {
        recipesTable.delegate = self
        recipesTable.dataSource = self
        
        recipesTable.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        view.addSubview(recipesTable)
        
        recipesTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            recipesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            recipesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
}

extension AllRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recipes.count)
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipesTable.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        cell.configure(with: recipes[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(RecipeViewController(recipe: recipes[indexPath.row]), animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

