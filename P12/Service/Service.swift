//
//  Service.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation
import Alamofire

class Service {

    // MARK: - Singleton
    static var shared = Service()
    
    
    // MARK: - Init
    private let session: SessionProtocol
    init(session: SessionProtocol = Session()) {
            self.session = session
        }
    
    
    func fetchMatch(typeOfMatch: String, callback: @escaping (Bool, DataJSON?) -> Void) {
        let url = URL(string:  "https://api.pandascore.co/matches/" + "\(typeOfMatch)" + "?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4")!
 
        
        session.request(url: url) { (data) in
            
            guard data.response?.statusCode == 200 else {
                callback(false, nil)
                return
            }
            guard  let data = data.data else {
                callback(false, nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(DataJSON.self, from: data) else {
                callback(false, nil)
                return
            }
            
            callback(true, responseJSON)
            
        }
    }
    
    
}
