//
//  IngredientsListViewController.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 10.06.2024.
//

import UIKit

class IngredientsListViewController: UIViewController {
    
    // MARK: - Constants
    struct Const {
        static let cellReuseIdentifier = "ingredient"
    }
    
    // MARK: - Properties
    let ingredientsListView = IngredientsListView()
    private var ingredients: [Ingredient] = []

    // MARK: - Custom Initializer
    init(ingredients: [Ingredient] = []) {
        super.init(nibName: nil, bundle: nil)
        self.ingredients = ingredients
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = ingredientsListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
           
        setupNavigationBar()
        setupActions()
        setupTableView()
    }
    
    // MARK: - Setup Methods
    private func setupTableView() {
        ingredientsListView.tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: Const.cellReuseIdentifier)
        ingredientsListView.tableView.delegate = self
        ingredientsListView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        title = "Ingredients"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
    }
    
    private func setupActions() {
        ingredientsListView.searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        ingredientsListView.addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    @objc func addTapped() {
        let alert = UIAlertController(title: "Add Ingredient", message: nil, preferredStyle: .alert)

        alert.addTextField()
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            self.ingredients.append(Ingredient(name: textField.text!))
            self.ingredientsListView.tableView.reloadData()
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func editTapped() {
        ingredientsListView.tableView.setEditing(!ingredientsListView.tableView.isEditing, animated: true)

        if ingredientsListView.tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
    }
    
    @objc func searchTapped() {
        let matchingRecipes = RecipeService.shared.findRecipes(byIngredients: ingredients)
        let allRecipesViewController = AllRecipesViewController(recipes: matchingRecipes)
        
        navigationController?.pushViewController(allRecipesViewController, animated: true)
    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension IngredientsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.ingredients.remove(at: indexPath.row)
            self.ingredientsListView.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }

        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
}

extension IngredientsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = ingredients[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseIdentifier) as! IngredientTableViewCell
        
        cell.configure(ingredient: ingredient.name) { [weak self] updatedIngredient in
            self?.ingredients[indexPath.row].name = updatedIngredient
        }
        return cell
    }
}
