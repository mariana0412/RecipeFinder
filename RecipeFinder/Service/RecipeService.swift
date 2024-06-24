//
//  RecipeService.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 16.06.2024.
//

import Foundation

class RecipeService {
    struct Const {
        static let fileName = "recipes.json"
    }

    static let shared = RecipeService()
    private(set) var recipes: [Recipe] = []
    private var fileNeedsChanging = false
    private let fileURL: URL

    private init() {
        let documentDirectoryUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectoryUrl = documentDirectoryUrls.first else {
            fatalError("Could not find the documents directory")
        }
        fileURL = documentDirectoryUrl.appendingPathComponent(Const.fileName)
        recipes = loadRecipesFromFile()
    }

    private func loadRecipesFromFile() -> [Recipe] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            guard let bundlePath = Bundle.main.path(forResource: "recipes", ofType: "json") else { return [] }
            do {
                try FileManager.default.copyItem(atPath: bundlePath, toPath: fileURL.path)
            } catch {
                print("Error copying initial recipes file: \(error)")
                return []
            }
            return loadRecipesFromFile()
        }

        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            print("Error occurred while loading recipes: \(error)")
            return []
        }
    }
    
    func findRecipes(byIngredients ingredients: [Ingredient], threshold: Double = 0.1) -> [Recipe] {
        let ingredientSet = Set(ingredients.map { $0.name.lowercased().trimmingCharacters(in: .whitespaces) })
        var matchingRecipes: [Recipe] = []

        for recipe in recipes {
            let recipeIngredientSet = Set(recipe.ingredients.map { $0.lowercased().trimmingCharacters(in: .whitespaces) })
            let commonIngredients = ingredientSet.filter { ingredient in
                recipeIngredientSet.contains { $0.contains(ingredient) }
            }
            
            if Double(commonIngredients.count) / Double(recipeIngredientSet.count) >= threshold {
                matchingRecipes.append(recipe)
            }
        }

        return matchingRecipes
    }
    
    func updateRecipe(_ updatedRecipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == updatedRecipe.id }) {
            recipes[index] = updatedRecipe
            fileNeedsChanging = true
        }
    }
    
    func saveChangesToFile() {
        if fileNeedsChanging {
            do {
                let data = try JSONEncoder().encode(recipes)
                try data.write(to: fileURL, options: .atomic)
                fileNeedsChanging = false
            } catch {
                print("Error occurred while saving recipes: \(error)")
            }
        }
    }

}
