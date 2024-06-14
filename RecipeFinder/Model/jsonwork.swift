//
//  jsonwork.swift
//  RecipeFinder
//
//  Created by Анастасія Грисюк on 14.06.2024.
//

import Foundation

struct Welcome: Codable {
    let name: String
    let id, minutes, contributorID: Int
    let submitted, tags: String
    let nutrition: [Double]
    let nSteps: Int
    let steps, description, ingredients: String
    let nIngredients, recipeID, averageRating, reviewCount: Int

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


class x {
    static let subjectsFilePath = Bundle.main.path(forResource: "csvjson", ofType: "json")
    
    static let time = Int()
    
    static func fetchSubjectsFromFile() {
        do {
            if let subjectsFilePath = subjectsFilePath {
                let date = Date()
                let data = try Data(contentsOf: URL(fileURLWithPath: subjectsFilePath))
                let decoder = JSONDecoder()
                let subjects = try decoder.decode([Welcome].self, from: data)
                let date2 = Date()
                print(date)
                print(date2)
            }
        } catch {
            print("Помилка при читанні або парсингу JSON-файлу:", error.localizedDescription)
        }
    }
    
}
