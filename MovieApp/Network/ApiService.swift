//
//  ApiService.swift
//  MovieApp
//
//  Created by APPLE on 07/09/21.
//

import Foundation
import Alamofire
import SwiftyJSON

import Foundation

struct NetworkConstants {
    static let api_key = "742a5ac51f96606624c001c3099c8e4c"
    static let imagesBaseURL = "https://image.tmdb.org/t/p/w500/"
}

enum NetworkEnvironment: String {
    case development
}

enum FetchingServiceState: Equatable {
    case loading
    case finishedLoading
    case error(String?)
}

enum NetworkAPI {
    
    fileprivate var networkEnvironment: NetworkEnvironment {
        return .development
    }
    
    case getPopulerMovies
    case getMovieDetails(Int)

}

extension NetworkAPI {
    private var baseURL: String {
        switch networkEnvironment {
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var path: String {
        var servicePath = ""
        switch self {
        case .getPopulerMovies:
            servicePath = "movie/popular?api_key=\(NetworkConstants.api_key)"
        case .getMovieDetails(let movieId):
            servicePath = "movie/\(movieId)?api_key=\(NetworkConstants.api_key)"
        }
        
        return baseURL + servicePath
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getPopulerMovies, .getMovieDetails(_):
            return .get
        }
    }
    
}


struct ApiService {
    func requestProcess(networkAPI: NetworkAPI,completionHandler: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        AF.request(networkAPI.path , method: networkAPI.method).responseJSON { response in
            switch (response.result){
            case .success(let datawork):
                let json =  JSON(datawork)
                completionHandler(json,nil)
                
            case .failure(_):
                completionHandler(nil,response.error)
                
            }
        }
    }
}
