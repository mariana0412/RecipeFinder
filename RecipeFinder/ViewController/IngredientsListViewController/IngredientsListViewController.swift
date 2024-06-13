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
    private var tableView: UITableView = UITableView()
    private var ingredients: [Ingredient] = []
    private var searchButton: UIButton = ButtonFactory.makeButton(withTitle: "Search", imageName: "magnifyingglass")
    private var addButton: UIButton = UIButton(type: .system)

    // MARK: - Custom Initializer
    init(ingredients: [Ingredient] = []) {
        super.init(nibName: nil, bundle: nil)
        self.ingredients = ingredients
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
        setupNavigationBar()
        setupActions()
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        view.addSubview(tableView)        
        view.addSubview(searchButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: Const.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.setTitle("Add", for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.addSubview(addButton)
        tableView.tableHeaderView = headerView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -10),
            
            addButton.centerXAnchor.constraint(equalTo: tableView.tableHeaderView!.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: tableView.tableHeaderView!.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalTo: tableView.tableHeaderView!.widthAnchor, constant: -40),
            
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Ingredients"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
   }
    
    private func setupActions() {
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
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
    
    @objc func searchTapped() {
        let allRecipesViewController = AllRecipesViewController()
        navigationController?.pushViewController(allRecipesViewController, animated: true)
    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
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
