//
//  RecipeModel.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
    let title: String?
    let image: String?
    let pricePerServing: Double?
    let readyInMinutes, servings: Int?
}
