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



