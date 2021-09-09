//
//  MovieInfoViewModel.swift
//  MovieApp
//
//  Created by APPLE on 07/09/21.
//

import Foundation

class MovieInfoViewModel {

    //Obsevable
    private (set) var state: Observable<FetchingServiceState> = Observable(.loading)
    private (set) var errorMsg : Observable<String> = Observable("")
    private (set) var movieList: Observable<[Movie]> = Observable([])
    private (set) var movieDetails: Observable<MovieDetailModel> = Observable(MovieDetailModel(data: [:]))
    fileprivate var movieInfoService : IMovieInfoServiceProtocol
    let MovieDetailSection : [MovieDetailsSection] = [.MovieTitle,.MoviePoster,.Rating,.Genres,.Languages,.Overview]
    
    init(apiClient: IMovieInfoServiceProtocol) {
        movieInfoService = apiClient
    }
    
}

//MARK:- API Call
extension MovieInfoViewModel {
    func callMovieListAPI() {
    state.value = .loading
        movieInfoService.fetchMovieList() { [weak self] (data, error) in
            self?.state.value = .finishedLoading
            DispatchQueue.main.async {
                if let response = data {
                    self?.movieList.value.append(contentsOf: response.result)
                } else if let err = error {
                    self?.state.value = .error(err)
                    self?.errorMsg.value = err
                }
            }
        }
    }
    
    func callMovieDetailsAPI(movieId: Int) {
        movieInfoService.fetchMovieDetails(movieId: movieId) { [weak self] (data, error) in
            DispatchQueue.main.async {
                if let response = data {
                    self?.movieDetails.value = response
                } else if let err = error {
                    self?.errorMsg.value = err
                }
            }
        }
    }
}


