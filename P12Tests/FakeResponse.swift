//
//  FakeResponse.swift
//  P12Tests
//
//  Created by Thibault Ballof on 18/08/2022.
//

import Foundation
@testable import P12

class FakeResponseData {
    //MARK: - Data
    static var goodData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "goodjson", withExtension: ".json")!
        return try! Data(contentsOf: url)
    }

    static var noData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "badjson", withExtension: ".json")!
        return try! Data(contentsOf: url)
    }


    static let incorrectData = "erreur".data(using: .utf8)

    //MARK: - Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!

    //MARK: - Error
    class FakeError: Error {}
    static let error = FakeError()
}
