//
//  Session.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import Foundation
import Alamofire

final class Session: SessionProtocol {
    func request(url: URL, callback: @escaping (AFDataResponse<DataJSON>) -> Void) {
        AF.request(url).responseDecodable(of: DataJSON.self) { dataResponse in
            callback(dataResponse)
        }
    }
    
}
