//
//  GamesObject.swift
//  P12
//
//  Created by Thibault Ballof on 21/07/2022.
//

import Foundation

struct GamesObject: Codable {
    let name: String
    let gameImg: String
    let urlStanding: String
    let urlUpcoming: String
}


struct GamesResultObject: Codable {
    let gameObject: [GamesObject]
}
