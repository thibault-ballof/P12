//
//  Service.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation
import Alamofire
import UIKit

class Service {
    
    static let shared = Service()

    
    func fetchMatch(typeOfMatch: String, completionHandler: @escaping ([DataJson]?) -> Void){
        let url = URL(string:  "https://api.pandascore.co/matches/" + "\(typeOfMatch)" + "?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
       
        AF.request(url)
            .validate()
            .responseDecodable(of: [DataJson].self) { (response) in
                guard let matchs = response.value else { return }
                completionHandler(matchs)
            }
        
    }
    
    func fetchLeagues(game: String, completionHandler: @escaping ([DataJson]?) -> Void) {
        let url = URL(string:  "https://api.pandascore.co/" + game + "/tournaments?&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: [DataJson].self) { (response) in
                guard let matchs = response.value else { return }
                completionHandler(matchs)
            }
    }
    func fetchRanking(completionHandler: @escaping ([RankingData]?) -> Void) {
        let url = URL(string:  "https://api.pandascore.co/tournaments/league-of-legends-lfl-summer-2022-regular-season/standings?page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: [RankingData].self) { (response) in
                print(response)
                guard let matchs = response.value else { return }
                completionHandler(matchs)
                print(matchs.count)
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
    
}
