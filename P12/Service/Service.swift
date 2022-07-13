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
    var dataFromDB: URLFromDB?
    private var leagues: [String] = []
    var matchData: [PandaJson]!

    private var session = Session(configuration: .default)
    init(session: Session) {
        self.session = session
    }
    func fetch(ingredient: [String], callback: @escaping (Bool, [PandaJson]?) -> Void) {



        let request = session.request("https://api.pandascore.co/matches/upcoming?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")

        request.response { (receivedData) in

            guard receivedData.response?.statusCode == 200 else {
                callback(false, nil)
                return
            }

            guard let responseJSON = try? JSONDecoder().decode([PandaJson].self, from: receivedData.data!) else {
                callback(false, nil)
                return
            }

            callback(true, responseJSON)



        }

    }


    func fetchMatch(completionHandler: @escaping ([PandaJson]?) -> Void){
        let url = URL(string:  "https://api.pandascore.co/matches/upcoming?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!


        AF.request(url)
            .validate()
            .responseDecodable(of: [PandaJson].self) { (response) in
                guard let matchs = response.value else { return }
                completionHandler(matchs)
            }
        
    }
    
    func fetchLeagues(game: String, completionHandler: @escaping ([PandaJson]?) -> Void) {
        let url = URL(string:  "https://api.pandascore.co/" + game + "/tournaments?&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: [PandaJson].self) { (response) in
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
    
    func fetchImage(url: String, image: UIImageView) {
        AF.request(url).response { response in
            switch response.result {
            case .success(let responseData):
                image.image = UIImage(data: responseData!)
            case .failure(let error):
                print("error--->",error)
            }
        }
    }
    
    func fetchURLFromDB(collection: String, document: String, completionHandler: @escaping (URLFromDB) -> Void) {
      let docRef = db.collection(collection).document(document)
        print("BDD : \(docRef)")
      docRef.getDocument { document, error in
          if let document = document {
            let data = document.data()
            let name = data?["name"] as? String ?? ""
            let url = data?["url"] as? String ?? ""
            let imgURL = data?["imgurl"] as? String ?? ""
              self.dataFromDB = URLFromDB(name: name, url: url, imgurl: imgURL)
              completionHandler(self.dataFromDB!)
              
          }
        }
      }

    func fetchLeaguesFromDB(collection: String, completionHandler: @escaping ([String]) -> Void) {
        db.collection(collection).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                self.leagues = []
                for document in querySnapshot!.documents {
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
            }
        }
      }

}
