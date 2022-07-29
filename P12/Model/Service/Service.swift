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


    func fetch(callback: @escaping (Bool, [PandaJSON]?) -> Void) {
        let url = URL(string:  "https://api.pandascore.co/matches/upcoming?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
        AF.request(url)
            .validate()
            .responseDecodable(of: [PandaJSON].self) { (response) in
                guard let matchs = response.value else {
                    callback(false, nil)
                    return
                }
                callback(true, matchs)
            }
    }


    func fetchMatch(url: String, completionHandler: @escaping ([PandaJSON]?) -> Void){

        let url = URL(string: url)!

        AF.request(url)
            .validate()
            .responseDecodable(of: [PandaJSON].self) { (response) in
                guard let matchs = response.value else { return }
                /*for i in 1...matchs.count {
                 if matchs[i-1].opponents.isEmpty == false {
                 self.matchData.append(matchs[i-1])
                 }*/

                completionHandler(matchs)
            }


        
    }
    
    func fetchLeagues(game: String, completionHandler: @escaping ([PandaJSON]?) -> Void) {
        let url = URL(string:  "https://api.pandascore.co/" + game + "/tournaments?&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: [PandaJSON].self) { (response) in
                guard let matchs = response.value else { return }
                completionHandler(matchs)
            }
    }
    func fetchRanking(url: String, completionHandler: @escaping ([RankingData]?) -> Void) {
        
        let url = URL(string:  url)!
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: [RankingData].self) { (response) in

                guard let matchs = response.value else { return }

                completionHandler(matchs)
                
            }
    }
    
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
