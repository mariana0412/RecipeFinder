//
//  Recipe.swift
//  RecipeFinder
//
//  Created by Анастасія Грисюк on 09.06.2024.
//

import Foundation
import UIKit

struct Recipe: Codable {
    let name: String
    let id, minutes, contributorID: Int
    let submitted, tags: String
    let nutrition: [Double]
    let nSteps: Int
    let steps, description: String
    let ingredients: String
    let nIngredients, recipeID, averageRating, reviewCount: Int
    
    var formattedName: String {
        return name.capitalized
    }

    enum CodingKeys: String, CodingKey {
        case name, id, minutes
        case contributorID = "contributor_id"
        case submitted, tags, nutrition
        case nSteps = "n_steps"
        case steps, description, ingredients
        case nIngredients = "n_ingredients"
        case recipeID = "recipe_id"
        case averageRating = "average_rating"
        case reviewCount = "review_count"
    }
}
