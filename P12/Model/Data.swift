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
   // let officialStreamURL: JSONNull?
    //let leagueID: Int
    //let scheduledAt, modifiedAt: String
    //let serie: Serie
    let opponents : [Opponents]

    //enum CodingKeys: String, CodingKey {
        //case winner
        //case serieID = "serie_id"
        //case officialStreamURL = "official_stream_url"
        //case leagueID = "league_id"
        //case scheduledAt = "scheduled_at"
        //case modifiedAt = "modified_at"
        //case serie
//}
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
   // let location: String?
   // let modifiedAt: String
    let name, slug: String?

}

