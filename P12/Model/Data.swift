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
    //let winner: JSONNull?
    let serie_id: Int
    let live_embed_url: String?
   // let officialStreamURL: JSONNull?
    //let leagueID: Int
    //let scheduledAt, modifiedAt: String
    let status: String?
    let original_scheduled_at: String?
    let serie: Serie
    let number_of_games: Int?
   // let live: Live
    let league: League
    let games: [Games]
    let opponents : [Opponents]
    let results: [Results]

    //enum CodingKeys: String, CodingKey {
        //case winner
        //case serieID = "serie_id"
        //case officialStreamURL = "official_stream_url"
        //case leagueID = "league_id"
        //case scheduledAt = "scheduled_at"
        //case modifiedAt = "modified_at"
        //case serie
//}
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

/*struct Live: Codable {
    let url: String
}*/

// MARK: - OpponentOpponent
struct Opponent: Codable {
    let acronym: String?
    let id: Int
    let image_url: String?
   // let location: String?
   // let modifiedAt: String
    let name, slug: String?

}

