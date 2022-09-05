//
//  TestNetwork.swift
//  P12Tests
//
//  Created by Thibault Ballof on 18/08/2022.
//

import Foundation
import XCTest
import Alamofire
import Lottie
@testable import P12
import AVFoundation

struct User: Codable {
    let name: String
}
class TestNetwork: XCTestCase {
    private var network: NetworkCall!

    override func setUp() {
        super.setUp()

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        network = NetworkCall(session: session)

    }
    /// It should correctly fetch and parse the user.
    func testFetchDataWithIncorrectJson() {
        /*MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.goodData
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
        }*/

        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "badjson", withExtension: ".json")!

        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        network = NetworkCall(session: sessionManager)
        network.url = "\(url)"
        network.method = .get
        network.headers = [:]
        network.encoding = URLEncoding.default
        network.executeQuery(){
            (result: Result<[RankingData],Error>) in
            switch result{
            case .success(let post):
                print(post)

            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, "Response could not be serialized, input data was nil or zero length.")

            }

        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 10.0)
    }


    func testFetchDataWithCorrectJson() {
        //when
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "goodjson", withExtension: ".json")!

        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        network = NetworkCall(session: sessionManager)
        network.url = "\(url)"
        network.method = .get
        network.headers = [:]
        network.encoding = URLEncoding.default

        network.executeQuery(){

            (result: Result<[PandaJSON],Error>) in
            switch result{
            case .success(let post):
                print(post)
                XCTAssertNotNil(post)
                XCTAssertEqual(post.first?.league.name, "VALORANT Champions Tour")
                expectation.fulfill()
            case .failure(let error):
                print(error)
            }
            self.wait(for: [expectation], timeout: 10)
        }

    }


    func testFetchDataWithIncorrectURL() {
        //when

      
        
        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        network = NetworkCall(session: sessionManager)
        network.url = "http://fakeurl.swift"
        network.method = .get
        network.headers = [:]
        network.encoding = URLEncoding.default

        network.executeQuery(){

            (result: Result<[PandaJSON],Error>) in
            switch result{
            case .success(let post):
                print(post)
                XCTAssertNil(post)
                //XCTAssertEqual(post.first?.league.name, "VALORANT Champions Tour")

            case .failure(let error):
                print(error)
                XCTAssertNotNil(error)

                expectation.fulfill()
            }
            self.wait(for: [expectation], timeout: 10)
        }

    }
    func testFetchDataWithDataAndGoodResponseAndNoError() {
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.goodData
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
        }


        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        network = NetworkCall(session: sessionManager)
        network.url = "https://google.fr"
        network.method = .get
        network.headers = [:]
        network.encoding = URLEncoding.default
        network.executeQuery(){
            (result: Result<[PandaJSON],Error>) in
            switch result{
            case .success(let post):
                print(post)
                XCTAssertEqual(post.first?.league.name, "VALORANT Champions Tour")
            case .failure(let error):
                //XCTAssertNotNil(error)
                print(error)
                //XCTAssertEqual(error.localizedDescription, "Response could not be serialized, input data was nil or zero length.")

            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchDataWithIncorrectDataAndGoodResponseAndNoError() {
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = FakeResponseData.noData
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            return (response, data, error)
        }


        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        network = NetworkCall(session: sessionManager)
        network.url = "https://google.fr"
        network.method = .get
        network.headers = [:]
        network.encoding = URLEncoding.default
        network.executeQuery(){
            (result: Result<[PandaJSON],Error>) in
            switch result{
            case .success(let post):
                print(post)
                //XCTAssertEqual(post.first?.league.name, "VALORANT Champions Tour")
            case .failure(let error):
                XCTAssertNotNil(error)
                print(error)
                //XCTAssertEqual(error.localizedDescription, "Response could not be serialized, input data was nil or zero length.")

            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }


    func testFetchDataWithNoDataAndBadResponseAndNoError() {
        MockURLProtocol.loadingHandler = { request in
            let data: Data? = nil
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = nil
            return (response, data, error)
        }


        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        network = NetworkCall(session: sessionManager)
        network.url = "https://google.fr"
        network.method = .get
        network.headers = [:]
        network.encoding = URLEncoding.default
        network.executeQuery(){
            (result: Result<[PandaJSON],Error>) in
            switch result{
            case .success(let post):
                print(post)
                //XCTAssertEqual(post.first?.league.name, "VALORANT Champions Tour")
            case .failure(let error):
                XCTAssertNotNil(error)
                print(error)
                //XCTAssertEqual(error.localizedDescription, "Response could not be serialized, input data was nil or zero length.")

            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
