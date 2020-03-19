//
//  RecipesModel.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/5/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

// MARK: - Recipes
struct RecipesData: Codable {
    let recipes: [RecipeData]
}

// MARK: - Recipe
struct RecipeData: Codable {
    let title: String?
    let image: String?
}
