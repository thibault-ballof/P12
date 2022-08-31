//
//  TestFirestore.swift
//  P12Tests
//
//  Created by Thibault Ballof on 29/08/2022.
//

import Foundation
import Firebase
@testable import P12
import XCTest
//MARK: - YOU NEED TO INSTALL FIRESTORE EMULATOR TO USE THIS TESTS
///Open the terminal and install/upgrade the Firebase CLI.
///Install using curl -sL firebase.tools | bash.
///Upgrade using curl -sL firebase.tools | upgrade=true | bash.
///
///In Terminal, cd to your choice of folder and create a new folder specifically for this Firebase project.
///In terminal enter : "Firebase init" then select Firestore and Emulators
///Now, hit enter and select “Use an existing project.”
///Finaly enter firebase emulators:start
////!\ Keep Terminal open


class ServiceTest: XCTestCase {
    var gameObject: [GamesObject] = []
   // let selectedGame = "lol"
    //let wrongSelectedGame = "test"



    

    func test_FetchGame() {
      // addDataLeaguesToFirestore()
       // addDataGameToFirestore()
        
        //addWrongDataGameToFirestore()
       // addWrongDataLeaguesToFirestore()


        let exp = self.expectation(description: "Waiting for async operation")

        Service.shared.fetchGameFromDB { data in
            XCTAssertEqual(data.first?.name, "r6")
            exp.fulfill()
        }

        self.waitForExpectations(timeout: 1, handler: nil)
    }





   /* func test_GetLeaguesBIncorrectData() {
        let exp = self.expectation(description: "Waiting for async operation")

        Service.shared.fetchLeagueDB(collection: "fakeCollection") { data in
            XCTAssertNil(data)
            exp.fulfill()

        }

        self.waitForExpectations(timeout: 5, handler: nil)
    }*/

    func test_GetLeaguesBCorrectData() {
        let exp = self.expectation(description: "Waiting for async operation")

        Service.shared.fetchLeagueDB(collection: "lol") { data in
            XCTAssertNotNil(data)
            exp.fulfill()
        }

        self.waitForExpectations(timeout: 1, handler: nil)
    }





    func test_GetLeagueNameWithCorrectCollection() {
        let exp = self.expectation(description: "Waiting for async operation")

        Service.shared.fetchLeaguesFromDB(collection: "lol") { data in


            if data.count == 3 {
                XCTAssertNotNil(data)
                exp.fulfill()

            }
        }

        self.waitForExpectations(timeout: 1, handler: nil)
    }
    /*func test_GetLeagueNameWithIncorrectCollection() {
        let exp = self.expectation(description: "Waiting for async operation")

        Service.shared.fetchLeaguesFromDB(collection: "wrongSelectedGame") { data in
            XCTAssertNil(data)

        }
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }*/






    func test_FetchLeaguesURLFormDBWithCorrectDocument() {
        let exp = self.expectation(description: "Waiting for async operation")
        Service.shared.fetchLeaguesURLFromDB(document: "csgo") { data in
            XCTAssertEqual(data.name, "csgo")
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    /*func test_FetchLeaguesURLFormDBWithIncorrectDocument() {
        let exp = self.expectation(description: "Waiting for async operation")
        Service.shared.fetchLeaguesURLFromDB(document: "toto") { data in
            XCTAssertNil(data)
        }
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }*/








    func test_FetchURLFormDBWithCorrectDocument() {
        let exp = self.expectation(description: "Waiting for async operation")
        Service.shared.fetchURLFromDB(collection: "csgo", document: "IEM Cologne") { data in
            XCTAssertEqual(data.name, "IEM Cologne")
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

   /* func test_FetchURLFormDBWithIncorrectCollection() {
        let exp = self.expectation(description: "Waiting for async operation")
        Service.shared.fetchURLFromDB(collection: "csgoo", document: "IEM Cologne") { data in
            XCTAssertNil(data)
        }
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }*/

   /* func test_FetchURLFormDBWithIncorrectDocument() {
        let exp = self.expectation(description: "Waiting for async operation")
        Service.shared.fetchURLFromDB(collection: "csgo", document: "tata") { data in
            XCTAssertNil(data)
        }
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }
    func test_FetchURLFormDBWithIncorrectData() {
        let exp = self.expectation(description: "Waiting for async operation")
        Service.shared.fetchURLFromDB(collection: "csgo", document: "tata") { data in
            XCTAssertNil(data)
        }
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }*/

}
