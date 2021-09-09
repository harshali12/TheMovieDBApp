//
//  MovieInfoService.swift
//  MovieApp
//
//  Created by APPLE on 08/09/21.
//

import Foundation

struct MovieInfoService : IMovieInfoServiceProtocol {
    
    func fetchMovieList(completion: @escaping (MovieModelData?,String?) -> Void) {
        ApiService().requestProcess(networkAPI: .getPopulerMovies) { (json, error) in
            if let jsonData = json {
                completion(MovieModelData(data: jsonData),nil)
            } else if let err = error {
                completion(nil, err.localizedDescription)
            } else {
                completion(nil, ErrorMessage.SomethingWentWrong.rawValue)
            }
        }
    }
    
    func fetchMovieDetails(movieId: Int,completion: @escaping (MovieDetailModel?,String?) -> Void) {
        ApiService().requestProcess(networkAPI: .getMovieDetails(movieId)) { (json, error) in
            if let jsonData = json {
                completion(MovieDetailModel(data: jsonData),nil)
            } else if let err = error {
                completion(nil, err.localizedDescription)
            } else {
                completion(nil, ErrorMessage.SomethingWentWrong.rawValue)
            }
        }
    }
    
}


