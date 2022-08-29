//
//  Network.swift
//  P12
//
//  Created by Thibault Ballof on 26/07/2022.
//

import Foundation
import Alamofire
//MARK: - Generic Network Call
/**
 Make request with AlamoFire


headers: [String:String] = In this you can send custom headers that you want to send along with the request

url = Here you can specify full url, you can leave it blank if you already have defined baseurl in Class. it comes handy when you want to consume a REST service provided by a third party. Note: if you are filling the url then you should the next parameter service should be nil

service: services = It's an enum defined in the NetworkClass itself. these serves as endPoints. Look in the init method, if the url is nil but the service is not nil then it will append at the end of base url to make a full URL, example will be provided.

method: HTTPMethod = here you can specify which HTTP Method the request should use.

isJSONRequest = set to true by default. if you want to send normal request set it to false.
*/
class NetworkCall: NSObject {



    enum services: String{
        case posts = "posts"
    }
    var parameters = Parameters()
    var headers = HTTPHeaders()
    var method: HTTPMethod!
    var url: String! = "https://google.fr"
    var encoding: ParameterEncoding! = JSONEncoding.default

    static let shared = NetworkCall(url: "https://google.fr")

  private init(headers: [String:String] = [:],url :String?,service :services? = nil, method: HTTPMethod = .post, isJSONRequest: Bool = false){
        super.init()
        headers.forEach({self.headers.add(name: $0.key, value: $0.value)})
        if url == nil, service != nil{
            self.url += service!.rawValue
        }else{
            self.url = url
        }
        if !isJSONRequest{
            encoding = URLEncoding.default
        }
        self.method = method
        print("Service: \(service?.rawValue ?? self.url ?? "") \n data: \(parameters)")
    }

    private var session = Session(configuration: .default)
    init(session: Session) {
        self.session = session
    }

    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {

        
        //session.request(url,method: method, parameters: parameters, encoding: encoding, headers: headers).responseData (completionHandler: {response in

        session.request(url,method: method, parameters: parameters, encoding: encoding, headers: headers).responseData (completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print(String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                    default:
                     let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }




}

