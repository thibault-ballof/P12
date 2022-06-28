//
//  RankingData.swift
//  P12
//
//  Created by Thibault Ballof on 14/06/2022.
//

import Foundation
struct RankingData: Codable {
    let losses, rank: Int
    let team: Team
    let total, wins: Int
}


struct DBRankingData {
    let name: String
    let url : String
}
