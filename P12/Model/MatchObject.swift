//
//  Object.swift
//  P12
//
//  Created by Thibault Ballof on 27/06/2022.
//

import Foundation

struct MatchObject {
    let name : String
    let league: String
    let team: [TeamResult]
}
struct TeamResult {
    let team: String
    let imgUrl: String
}
