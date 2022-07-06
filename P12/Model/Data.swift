//
//  Data.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation

// MARK: - WelcomeElement
struct DataJson: Codable {
    let beginAt, endAt: Date
    let id: Int
    let league: League
    let leagueID: Int
    let liveSupported: Bool
    let matches: [Match]
    let modifiedAt: String
    let name: String
    let prizepool: String?
    let serie: Serie
    let serieID: Int
    let slug: String
    let teams: [Team]
    let tier: Tier
    let videogame: Videogame
    let winnerID: Int?
    let winnerType: WinnerType

    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case endAt = "end_at"
        case id, league
        case leagueID = "league_id"
        case liveSupported = "live_supported"
        case matches
        case modifiedAt = "modified_at"
        case name, prizepool, serie
        case serieID = "serie_id"
        case slug, teams, tier, videogame
        case winnerID = "winner_id"
        case winnerType = "winner_type"
    }
}

// MARK: - League
struct League: Codable {
    let id: Int
    let imageURL: String
    let modifiedAt: String
    let name: LeagueName
    let slug: LeagueSlug
    let url: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
        case modifiedAt = "modified_at"
        case name, slug, url
    }
}

enum LeagueName: String, Codable {
    case lck = "LCK"
    case midSeasonInvitational = "Mid-Season Invitational"
    case worlds = "Worlds"
}

enum LeagueSlug: String, Codable {
    case leagueOfLegendsLckChampionsKorea = "league-of-legends-lck-champions-korea"
    case leagueOfLegendsMidInvitational = "league-of-legends-mid-invitational"
    case leagueOfLegendsWorldChampionship = "league-of-legends-world-championship"
}

// MARK: - Match
struct Match: Codable {
    let beginAt: Date?
    let detailedStats, draw: Bool
    let endAt: Date?
    let forfeit: Bool
    let gameAdvantage: JSONNull?
    let id: Int
    let live: Live
    let liveEmbedURL: String?
    let matchType: MatchType
    let modifiedAt: String
    let name: String
    let numberOfGames: Int
    let officialStreamURL: String?
    let originalScheduledAt: Date
    let rescheduled: Bool
    let scheduledAt: Date
    let slug: String
    let status: Status
    let streams: Streams
    let streamsList: [StreamsList]
    let tournamentID: Int
    let winnerID: Int?

    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case detailedStats = "detailed_stats"
        case draw
        case endAt = "end_at"
        case forfeit
        case gameAdvantage = "game_advantage"
        case id, live
        case liveEmbedURL = "live_embed_url"
        case matchType = "match_type"
        case modifiedAt = "modified_at"
        case name
        case numberOfGames = "number_of_games"
        case officialStreamURL = "official_stream_url"
        case originalScheduledAt = "original_scheduled_at"
        case rescheduled
        case scheduledAt = "scheduled_at"
        case slug, status, streams
        case streamsList = "streams_list"
        case tournamentID = "tournament_id"
        case winnerID = "winner_id"
    }
}

// MARK: - Live
struct Live: Codable {
    let opensAt: Date?
    let supported: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case opensAt = "opens_at"
        case supported, url
    }
}

enum MatchType: String, Codable {
    case bestOf = "best_of"
}

enum Status: String, Codable {
    case canceled = "canceled"
    case finished = "finished"
}

// MARK: - Streams
struct Streams: Codable {
    let english, official, russian: English
}

// MARK: - English
struct English: Codable {
    let embedURL: String?
    let rawURL: String?

    enum CodingKeys: String, CodingKey {
        case embedURL = "embed_url"
        case rawURL = "raw_url"
    }
}

// MARK: - StreamsList
struct StreamsList: Codable {
    let embedURL: String?
    let language: Language
    let main, official: Bool
    let rawURL: String

    enum CodingKeys: String, CodingKey {
        case embedURL = "embed_url"
        case language, main, official
        case rawURL = "raw_url"
    }
}

enum Language: String, Codable {
    case de = "de"
    case en = "en"
    case es = "es"
    case fr = "fr"
    case it = "it"
    case ko = "ko"
    case pl = "pl"
    case pt = "pt"
    case ru = "ru"
}

// MARK: - Serie
struct Serie: Codable {
    let beginAt: Date
    let serieDescription: JSONNull?
    let endAt: Date
    let fullName: String
    let id, leagueID: Int
    let modifiedAt: String
    let name, season: String?
    let slug: SerieSlug
    let tier: Tier
    let winnerID: Int
    let winnerType: WinnerType
    let year: Int

    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case serieDescription = "description"
        case endAt = "end_at"
        case fullName = "full_name"
        case id
        case leagueID = "league_id"
        case modifiedAt = "modified_at"
        case name, season, slug, tier
        case winnerID = "winner_id"
        case winnerType = "winner_type"
        case year
    }
}

enum SerieSlug: String, Codable {
    case leagueOfLegendsLckChampionsKoreaSummer2020 = "league-of-legends-lck-champions-korea-summer-2020"
    case leagueOfLegendsMidInvitational2021 = "league-of-legends-mid-invitational-2021"
    case leagueOfLegendsMidInvitational2022 = "league-of-legends-mid-invitational-2022"
    case leagueOfLegendsWorldChampionship2020 = "league-of-legends-world-championship-2020"
    case leagueOfLegendsWorldChampionship2021 = "league-of-legends-world-championship-2021"
}

enum Tier: String, Codable {
    case s = "s"
}

enum WinnerType: String, Codable {
    case team = "Team"
}

// MARK: - Team
struct Team: Codable {
    let acronym: String
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

// MARK: - Videogame
struct Videogame: Codable {
    let id: Int
    let name: VideogameName
    let slug: VideogameSlug
}

enum VideogameName: String, Codable {
    case loL = "LoL"
}

enum VideogameSlug: String, Codable {
    case leagueOfLegends = "league-of-legends"
}

typealias Data = [DataJson]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

struct URLFromDB: Codable {
    let name: String
    let url: String
    let imgurl: String
}

/*struct DataJSON: Codable {
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
*/
