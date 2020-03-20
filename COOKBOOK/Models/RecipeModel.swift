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
    let instructions: String?
    let extendedIngredients: [ExtendedIngredient]
}

enum Consistency: String, Codable {
    case liquid = "liquid"
    case solid = "solid"
}

struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle, image: String?
    let consistency: Consistency?
    let name, original, originalString, originalName: String?
    let amount: Double?
    let unit: String?
    let meta, metaInformation: [String]
    let measures: Measures?
}

struct Measures: Codable {
    let us, metric: Metric?
}

struct Metric: Codable {
    let amount: Double?
    let unitShort, unitLong: String?
}
