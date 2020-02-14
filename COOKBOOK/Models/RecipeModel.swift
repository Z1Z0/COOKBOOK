//
//  RecipeModel.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    let results: [Result]
    let baseURI: String
    let offset, number, totalResults, processingTimeMS: Int
    let expires: Int
    let isStale: Bool

    enum CodingKeys: String, CodingKey {
        case results
        case baseURI = "baseUri"
        case offset, number, totalResults
        case processingTimeMS = "processingTimeMs"
        case expires, isStale
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let image: String
    let imageUrls: [String]
}
