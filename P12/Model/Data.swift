//
//  Data.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation

struct DataJSON: Codable {
    let winnerIdentitifier: Int?
    let leagueIdentitifier: Int
    let beginAt: String
    let league: League
    let tournament: Tournament
    let identitifier: Int
    let winner: String?
    let opponents: [Opponents]
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
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        winnerIdentitifier = try values.decodeIfPresent(Int.self, forKey: .winnerIdentitifier)
        leagueIdentitifier = try values.decode(Int.self, forKey: .leagueIdentitifier)
        beginAt = try values.decode(String.self, forKey: .beginAt)
        league = try values.decode(League.self, forKey: .league)
        tournament = try values.decode(Tournament.self, forKey: .tournament)
        identitifier = try values.decode(Int.self, forKey: .identitifier)
        winner = try values.decodeIfPresent(String.self, forKey: .winner)
        opponents = try values.decode([Opponents].self, forKey: .opponents)
        videogame = try values.decode(Videogame.self, forKey: .videogame)
        numberOfGames = try values.decode(Int.self, forKey: .numberOfGames)
        name = try values.decode(String.self, forKey: .name)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        
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
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        identitifier = try values.decode(Int.self, forKey: .identitifier)
        name = try values.decode(String.self, forKey: .name)
    }
    
}

struct Tournament: Codable {
    let name: String
}
struct Opponents: Codable {
    let opponent: Opponent
}

struct Opponent: Codable {
    let identitifier: Int?
    let imageURL: String?
    let name : String
    
    enum CodingKeys: String, CodingKey {
        
        case imageURL = "image_url"
        case identitifier = "id"
        case name
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        identitifier = try values.decodeIfPresent(Int.self, forKey: .identitifier)
        name = try values.decode(String.self, forKey: .name)
    }
}
struct Videogame: Codable {
    let identitifier: Int
    let name: String
    enum CodingKeys: String, CodingKey {
        
       
        case identitifier = "id"
        case name
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        identitifier = try values.decode(Int.self, forKey: .identitifier)
        name = try values.decode(String.self, forKey: .name)
    }
}
