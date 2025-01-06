//
//  Model.swift
//  exampleService
//
//  Created by Mert Ziya on 6.01.2025.
//

import Foundation

struct Model: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
