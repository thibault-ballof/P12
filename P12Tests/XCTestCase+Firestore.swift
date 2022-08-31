//
//  XCTestCase+Firestore.swift
//  P12Tests
//
//  Created by Thibault Ballof on 30/08/2022.
//

import XCTest
import Firebase
import FirebaseFirestore


extension XCTestCase {

    func addDataGameToFirestore() {

        let db = Firestore.firestore()
        let docRef = db.collection("games").document("csgo")

        docRef.setData(["name": "csgo", "gameImg": "test", "urlStanding": "https://api.pandascore.co/csgo/matches/running?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4", "urlUpcoming": "https://api.pandascore.co/csgo/matches/upcoming?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4"]) { err in
            if let err = err {
                print("Error Adding data \(err)")
            } else {
                print("added doc with ID: \(docRef.documentID)")
            }
        }

    }
   func addDataLeaguesToFirestore() {
        let db = Firestore.firestore()
        let docRef = db.collection("csgo").document("IEM Cologne")

        docRef.setData(["name": "IEM Cologne", "imgurl": "https://cdn.pandascore.co/images/league/image/4161/500px-IEM_logo_2014.png", "url": "https://api.pandascore.co/tournaments/cs-go-iem-cologne-xvii-2022-play-in/standings?page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4"]) { err in
            if let err = err {
                print("Error Adding data \(err)")
            } else {
                print("added doc with ID: \(docRef.documentID)")
            }
        }

    }

    func addWrongDataLeaguesToFirestore() {
        let db = Firestore.firestore()
        let docRef = db.collection("wrongcsgo").document("IEM Cologne")

        docRef.setData(["blabla" : "IEM Cologne"]) { err in
            if let err = err {
                print("Error Adding data \(err)")
            } else {
                print("added doc with ID: \(docRef.documentID)")
            }
        }

    }

    func addWrongDataGameToFirestore() {
        var docRef: DocumentReference? = nil
        let db = Firestore.firestore()
        docRef = db.collection("wronggames").document("csgo")

        docRef!.setData(["blabla": "csgor"]) { err in
            if let err = err {
                print("Error Adding data \(err)")
            } else {
                print("added doc with ID: \(docRef!.documentID)")
            }
        }

    }
}
