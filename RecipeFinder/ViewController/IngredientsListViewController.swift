//
//  IngredientsListViewController.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 10.06.2024.
//

import Foundation
import UIKit

class IngredientsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Constants
    struct Const {
        static let cellReuseIdentifier = "ingredient"
    }
    
    // MARK: - Properties
    var tableView: UITableView = UITableView()
    var ingredients: [Ingredient] = [Ingredient(name: "milk"), Ingredient(name: "juice"), Ingredient(name: "potato")]
    var searchButton: UIButton = ButtonFactory.makeButton(withTitle: "Search", imageName: "magnifyingglass")

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(searchButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: Const.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -10),
                        
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Ingredients"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
   }
    
    // MARK: - Action Methods
    @objc func addTapped() {
        let alert = UIAlertController(title: "Add Ingredient", message: nil, preferredStyle: .alert)

        alert.addTextField()
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            self.ingredients.append(Ingredient(name: textField.text!))
            self.tableView.reloadData()
        }

        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)

        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
    }

    // MARK: - UITableViewDelegate and UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.ingredients.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }

        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
    
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
