//
//  SearchWithIngredientsModel.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/22/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

class SearchWithIngredient: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
    let usedIngredientCount, missedIngredientCount: Int?
    let missedIngredients, usedIngredients: [SedIngredient]?
    let unusedIngredients: [JSONAny]?
    let likes: Int?
    var checked: Bool?
}

// MARK: - SedIngredient
class SedIngredient: Codable {
    let id: Int?
    let amount: Double?
    let unit, unitLong, unitShort, aisle: String?
    let name, original, originalString, originalName: String?
    let metaInformation, meta: [String]?
    let extendedName: String?
    let image: String?
}
