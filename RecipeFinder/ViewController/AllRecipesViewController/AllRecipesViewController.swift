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
    
    let sortingControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Default", "By Time"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = UIColor(named: "BackgroundColor")
        control.tintColor = UIColor(named: "LabelsColor")
        control.selectedSegmentTintColor = UIColor(named: "TextFieldColor")
        
        return control
    }()
    
    // MARK: - Custom Initializer
    init(recipes: [Recipe]) {
        self.recipes = recipes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = allRecipesView
        
        title = "Recipes"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.tintColor = UIColor(named: "ButtonColor")
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationItem.titleView = sortingControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        allRecipesView.recipesTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        setupActions()
    }
    
    // MARK: - Setup Methods
    private func setUpTable() {
        allRecipesView.recipesTable.delegate = self
        allRecipesView.recipesTable.dataSource = self
        
        allRecipesView.recipesTable.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCell")
    }
    
    private func setupActions() {
        sortingControl.addTarget(self, action: #selector(sortingOptionChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Action Methods
    @objc private func sortingOptionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            recipes.sort { $0.name < $1.name }
        case 1:
            recipes.sort { $0.minutes < $1.minutes }
        default:
            break
        }
        allRecipesView.recipesTable.reloadData()
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
        let recipeViewController = RecipeViewController(recipe: recipes[indexPath.row])
        recipeViewController.delegate = self
        navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension AllRecipesViewController: RecipeUpdateDelegate {
    func didUpdateFavoriteStatus(for recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
            allRecipesView.recipesTable.reloadData()
        }
    }
}
