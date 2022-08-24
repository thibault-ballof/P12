//
//  Service.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation
import Alamofire
import UIKit
import Firebase

class Service {
    
    static let shared = Service()
    private init() {}

    private let db = Firestore.firestore()


    private var leagues: [String] = []
    var matchData: [PandaJSON]!
    var gameObject: [GamesObject] = []
    var gameURL: [String] = []
    var games: [String] = []


    func fetchLeagueDB(collection: String, completionHandler: @escaping ([URLFromDB]) -> Void) {

        var dataFromDB: [URLFromDB] = []
        db.collection(collection).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                dataFromDB = []
                querySnapshot?.documents.forEach({ (document) in
                    if let name = document.data()["name"] as? String {
                        let docRef = self.db.collection(collection).document(name)
                        docRef.getDocument { document, error in
                            if let document = document {
                                let data = document.data()
                                let name = data?["name"] as? String ?? ""
                                let url = data?["url"] as? String ?? ""
                                let imgURL = data?["imgurl"] as? String ?? ""
                                dataFromDB.append(URLFromDB(name: name, url: url, imgurl: imgURL))
                                if dataFromDB.count == querySnapshot?.count  {

                                    completionHandler(dataFromDB)
                                }
                            }
                        }
                    }
                })
            }


        }

    }
    func fetchLeaguesURLFromDB(document: String, completionHandler: @escaping (GamesObject) -> Void) {
        var gamesObject: GamesObject?
        let docRef = db.collection("games").document(document)
        docRef.getDocument { document, error in
            if let document = document {
                let data = document.data()
                let name = data?["name"] as? String ?? ""
                let urlStanding = data?["urlStanding"] as? String ?? ""
                let img = data?["gameImg"] as? String ?? ""
                let urlUpcoming = data?["urlUpcoming"] as? String ?? ""
                gamesObject = GamesObject(name: name, gameImg: img, urlStanding: urlStanding, urlUpcoming: urlUpcoming)
                completionHandler(gamesObject!)
            }
        }
    }
    func fetchURLFromDB(collection: String, document: String, completionHandler: @escaping (URLFromDB) -> Void) {
        var dataFromDB: URLFromDB?
        let docRef = db.collection(collection).document(document)
        docRef.getDocument { document, error in
            if let document = document {
                let data = document.data()
                let name = data?["name"] as? String ?? ""
                let url = data?["url"] as? String ?? ""
                let imgURL = data?["imgurl"] as? String ?? ""
                dataFromDB = URLFromDB(name: name, url: url, imgurl: imgURL)
                completionHandler(dataFromDB!)
            }
        }
    }
    func fetchGameFromDB(completionHandler: @escaping ([GamesObject]) -> Void) {
        db.collection("games").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                self.gameObject = []
                querySnapshot?.documents.forEach({ (document) in
                    if let name = document.data()["name"] as? String {
                        let docRef = self.db.collection("games").document(name)
                        docRef.getDocument { document, error in
                            if let document = document {
                                let data = document.data()
                                let name = data?["name"] as? String ?? ""
                                let urlStanding = data?["urlStanding"] as? String ?? ""
                                let img = data?["gameImg"] as? String ?? ""
                                let urlUpcoming = data?["urlUpcoming"] as? String ?? ""
                                self.gameObject.append(GamesObject(name: name, gameImg: img, urlStanding: urlStanding, urlUpcoming: urlUpcoming))
                                if self.gameObject.count == querySnapshot?.count  {
                                    completionHandler(self.gameObject)
                                }
                            }
                        }
                    }
                })
            }
        }
    }

    func fetchLeaguesFromDB(collection: String, completionHandler: @escaping ([String]) -> Void) {
        db.collection(collection).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                self.gameObject = []
                querySnapshot?.documents.forEach({ (document) in
                    if let name = document.data()["name"] as? String {
                        if self.leagues.contains(name) {
                            print("alreay append")
                        } else {
                            self.leagues.append(name)
                            print(self.leagues)
                            completionHandler(self.leagues)
                        }
                    }
                }




                )}
        }

    }



}
