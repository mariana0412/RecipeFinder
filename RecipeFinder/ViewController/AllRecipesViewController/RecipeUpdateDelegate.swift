//
//  RecipeUpdateDelegate.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 24.06.2024.
//

import Foundation

protocol RecipeUpdateDelegate: AnyObject {
    func didUpdateFavoriteStatus(for recipe: Recipe)
}
