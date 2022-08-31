//
//  Data.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation

struct Matchs {
    let type: String
    let pandaJSON: [PandaJSON]

}
// MARK: - PandaJSONElement
struct PandaJSON: Codable {
    let serie_id: Int
    let live_embed_url: String?
    let status: String?
    let original_scheduled_at: String?
    let serie: Serie
    let number_of_games: Int?
    let league: League
    let games: [Games]
    let opponents : [Opponents]
    let results: [Results]


    struct Results: Codable {
        let score: Int?
        let team_id: Int?
    }

    struct Serie: Codable{
        let begin_at: String?
    }

    struct League: Codable {
        let name: String
        let image_url: String?
    }

   struct Games: Codable {
        let match_id: Int?
    }
}
struct Opponents: Codable {
    let opponent: Opponent
    let type: String
}


// MARK: - OpponentOpponent
struct Opponent: Codable {
    let acronym: String?
    let id: Int
    let image_url: String?
    let name, slug: String?

}

