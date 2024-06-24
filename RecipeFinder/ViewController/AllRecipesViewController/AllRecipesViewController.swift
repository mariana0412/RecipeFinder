//
//  AllRecipesViewController.swift
//  RecipeFinder
//
//  Created by Анастасія Грисюк on 09.06.2024.
//

import UIKit

class AllRecipesViewController: UIViewController {
    
    // MARK: - Properties
    let allRecipesView = AllRecipesView()
    var recipes: [Recipe]
        
    // MARK: - Custom Initializer
    init(recipes: [Recipe]) {
        let sortedRecipes = recipes.sorted { $0.minutes < $1.minutes }
        self.recipes = sortedRecipes
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = allRecipesView
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        allRecipesView.recipesTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
    }
    
    // MARK: - Setup Methods
    private func setUpTable() {
        allRecipesView.recipesTable.delegate = self
        allRecipesView.recipesTable.dataSource = self
        
        allRecipesView.recipesTable.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCell")
    }
}

// MARK: - UITableViewDataSource
extension AllRecipesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        cell.configure(with: recipes[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AllRecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(RecipeViewController(recipe: recipes[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
