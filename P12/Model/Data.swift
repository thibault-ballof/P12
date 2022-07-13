//
//  Data.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation

struct PandaJson: Codable {
    let winnerIdentitifier: Int?
    let leagueIdentitifier: Int
    let beginAt: String
    let league: League
    let tournament: Tournament
    let identitifier: Int
    let winner: String? 
    let opponents: [OpponentElement]
    let videogame: Videogame
    let numberOfGames: Int
    let name: String
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        
        case winnerIdentitifier = "winner_id"
        case leagueIdentitifier = "league_id"
        case beginAt = "begin_at"
        case league
        case tournament
        case identitifier = "id"
        case winner
        case opponents
        case videogame
        case numberOfGames = "number_of_games"
        case name
        case status
    }

}
struct League: Codable {
    let identitifier: Int
    let imageURL: String?
    let name: String
    enum CodingKeys: String, CodingKey {
        
        case imageURL = "image_url"
        case identitifier = "id"
        case name
    }

}

struct Tournament: Codable {
    let name: String
}


// MARK: - OpponentElement
struct OpponentElement: Codable {
    let opponent: OpponentOpponent
    let type: String
}

// MARK: - OpponentOpponent
struct OpponentOpponent: Codable {
    let acronym: String?
    let id: Int
    let imageURL: String
    let location: String?
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
struct Videogame: Codable {
    let identitifier: Int
    let name: String
    enum CodingKeys: String, CodingKey {
        
       
        case identitifier = "id"
        case name
    }
}
 

