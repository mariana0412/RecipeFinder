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
    let id: Int
    let minutes: Int
    let tags: [String]
    let steps: [String]
    let description: String
    let ingredients: [String]
    let averageRating: Int
    var isFavorite: Bool

    var formattedName: String {
        return name.capitalized
    }

    enum CodingKeys: String, CodingKey {
        case name, id, minutes, tags
        case steps, description, ingredients
        case averageRating = "average_rating"
        case isFavorite = "is_favorite"
    }
}
