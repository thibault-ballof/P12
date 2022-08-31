//
//  RankingData.swift
//  P12
//
//  Created by Thibault Ballof on 14/06/2022.
//

import Foundation
struct RankingData: Codable {
    let losses: Int?
    let rank: Int
    let team: Team
    let total: Int?
    let wins: Int?
}
struct Team: Codable {
    let acronym: String?
    let id: Int
    let imageURL: String
    let location: String?
    let modifiedAt: String
    let name, slug: String

    enum CodingKeys: String, CodingKey {
        case acronym, id
        case imageURL = "image_url"
        case location
        case modifiedAt = "modified_at"
        case name, slug
    }
} 

struct DBRankingData {
    let name: String
    let url : String
}

struct URLFromDB: Codable {
    let name: String?
    let url: String?
    let imgurl: String?
    
}


