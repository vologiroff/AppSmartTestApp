//
//  APIService.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import UIKit
import Alamofire

///Available URLs for making requests
enum URLs {
    static let version = "v1/public/"
    static let host = "https://gateway.marvel.com/"
    static let base = host + version
    
    static let feedModel = base + "characters"
}

///Sigleton APIService to make requests
class APIService {
    
    //MARK: - Properties
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private static let publicKey = "59cbbafca82e79ece451f9c16d0b1ea1"
    private static let privateKey = "23f5bfdcbab19b4caa86601d50ed9ae132274d4b"
    private static let plainTextToHash = timestamp + privateKey + publicKey
    
    public static let shared: APIService = APIService()
    
    private init() {}
    
    //MARK: - API methods
    
    public func fetchFeedModel(offset: Int, word: String? = nil, completion: @escaping (FeedModel?) -> ()) {
        var parameters: [String: Any] = ["apikey": APIService.publicKey,
                                         "ts": timestamp,
                                         "hash": encryptHashParameterWithMD5(string: APIService.plainTextToHash) ?? "",
                                         "limit": 12,
                                         "offset": offset]
        if word != nil {
            parameters = parameters.merging(["nameStartsWith": word!]) { current, new in current }
        }
        
        // Cancel Previous Requests
        Alamofire.Session.default.session.getAllTasks { (tasks) in
            tasks.forEach{
                $0.cancel()
            }
        }
    
        let request = AF.request(URLs.feedModel, parameters: parameters)
        
        request.responseDecodable(of: FeedModel.self, decoder: decoder) { response in
//            print(response.debugDescription)
            switch response.result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
