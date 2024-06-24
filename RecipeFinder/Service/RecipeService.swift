//
//  RecipeService.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 16.06.2024.
//

import Foundation

class RecipeService {
    static let shared = RecipeService()
    
    private var recipes: [Recipe] = []

    func loadRecipes() {
        guard let filePath = Bundle.main.path(forResource: "recipes", ofType: "json") else {
            print("Error: Recipe file path not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let decoder = JSONDecoder()
            self.recipes = try decoder.decode([Recipe].self, from: data)
        } catch {
            print("Error reading or parsing JSON file: \(error.localizedDescription)")
        }
    }
    
    func findRecipes(byIngredients ingredients: [Ingredient], threshold: Double = 0.7) -> [Recipe] {
            let ingredientSet = Set(ingredients.map { $0.name.lowercased().trimmingCharacters(in: .whitespaces) })
            var matchingRecipes: [Recipe] = []

            for recipe in recipes {
                var ingredientsString = recipe.ingredients
                ingredientsString = ingredientsString.replacingOccurrences(of: "'", with: "\"")
                let data = Data(ingredientsString.utf8)
                guard let recipeIngredients = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] else {
                    continue
                }
                
                let recipeIngredientSet = Set(recipeIngredients.map { $0.lowercased().trimmingCharacters(in: .whitespaces) })
                let commonIngredients = ingredientSet.filter { ingredient in
                    recipeIngredientSet.contains { $0.contains(ingredient) }
                }
                
                if Double(commonIngredients.count) / Double(recipeIngredientSet.count) >= threshold {
                    matchingRecipes.append(recipe)
                }
            }

            return matchingRecipes
        }

}
