//
//  Service.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation
import Alamofire

class Service {

    
    func fetchMatch(typeOfMatch: String, completionHandler: @escaping ([DataJSON]?) -> Void){
        let url = URL(string:  "https://api.pandascore.co/matches/" + "\(typeOfMatch)" + "?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
       
        AF.request(url)
            .validate()
            .responseDecodable(of: [DataJSON].self) { (response) in
                guard let matchs = response.value else { return }
                print(matchs.count)
                completionHandler(matchs)
            }
        
    }
    
    
}
