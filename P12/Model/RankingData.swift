//
//  RankingData.swift
//  P12
//
//  Created by Thibault Ballof on 13/06/2022.
//

import Foundation
struct RankingData: Codable {
    let losses, rank: Int
    let team: Team
    let total, wins: Int
}

// MARK: - Team
struct Team: Codable {
    let acronym: String
    let id: Int
    let imageURL: String
    let location: String
    let modifiedAt: Date
    let name, slug: String

    enum CodingKeys: String, CodingKey {
        case acronym, id
        case imageURL = "image_url"
        case location
        case modifiedAt = "modified_at"
        case name, slug
    }
}



