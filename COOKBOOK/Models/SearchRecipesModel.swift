//
//  SearchModel.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/8/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

class SearchRecipesModel: Codable {
    var results: [Result]?
    var baseURI: String?
    var offset, number, totalResults, processingTimeMS: Int?
    var expires: Int?
    var isStale: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case results
        case baseURI = "baseUri"
        case offset, number, totalResults
        case processingTimeMS = "processingTimeMs"
        case expires, isStale
    }
}

// MARK: - Result
class Result: Codable {
    var id: Int?
    var title: String?
    var readyInMinutes, servings: Int?
    var image: String?
    var imageUrls: [String]?
    var checked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, readyInMinutes, servings, image, imageUrls, checked
    }
}
