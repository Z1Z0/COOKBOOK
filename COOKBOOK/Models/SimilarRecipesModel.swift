//
//  SimilarRecipesModel.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 6/29/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

struct SimilarRecipesModel: Codable {
    
    let id: Int?
    let imageType: String?
    let readyInMinutes: Int?
    let servings: Int?
    let sourceUrl: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageType = "imageType"
        case readyInMinutes = "readyInMinutes"
        case servings = "servings"
        case sourceUrl = "sourceUrl"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageType = try values.decodeIfPresent(String.self, forKey: .imageType)
        readyInMinutes = try values.decodeIfPresent(Int.self, forKey: .readyInMinutes)
        servings = try values.decodeIfPresent(Int.self, forKey: .servings)
        sourceUrl = try values.decodeIfPresent(String.self, forKey: .sourceUrl)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
}
