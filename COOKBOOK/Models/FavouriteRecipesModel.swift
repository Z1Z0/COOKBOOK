//
//  FavouriteRecipesModel.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 5/1/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

// MARK: - FavouriteRecipes
struct FavouriteRecipes: Codable {
    let documents: [Document]?
}

// MARK: - Document
struct Document: Codable {
    let name: String?
    let fields: Fields?
    let createTime, updateTime: String?
}

// MARK: - Fields
struct Fields: Codable {
    let favRecipes: FavRecipes?

    enum CodingKeys: String, CodingKey {
        case favRecipes = "FavRecipes"
    }
}

// MARK: - FavRecipes
struct FavRecipes: Codable {
    let stringValue: String?
}
