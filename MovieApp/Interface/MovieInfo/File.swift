//
//  File.swift
//  MovieApp
//
//  Created by APPLE on 09/09/21.
//

import Foundation

protocol IMovieInfoServiceProtocol {
    
    func fetchMovieDetails(movieId: Int,completion: @escaping (MovieDetailModel?,String?) -> Void)
    func fetchMovieList(completion: @escaping (MovieModelData?,String?) -> Void)
    
}
