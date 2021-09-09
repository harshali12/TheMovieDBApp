//
//  MovieAppVMTest.swift
//  MovieAppTests
//
//  Created by APPLE on 09/09/21.
//

import XCTest
@testable import  MovieApp

class MovieAppVMTest: XCTestCase {

    //MARK:- FetchMovieList API
    func testFetchMovieList() {
        let viewModel = MovieInfoViewModel(apiClient: MovieInfoService())
        viewModel.callMovieListAPI()
        
        if !viewModel.errorMsg.value.isEmpty  {
            XCTAssert(false, "\(viewModel.errorMsg)")
        } else if viewModel.movieList.value.count > 0 {
            XCTAssert(true, "Movies fetch successfully")
        } else {
            XCTAssert(true, "No Movies")
        }
       
    }
    
    //MARK:- GetMovieDetails API
    func testMovieDetailsAPI() {
        let viewModel = MovieInfoViewModel(apiClient: MovieInfoService())
        viewModel.callMovieDetailsAPI(movieId: 482373)
        
        if !viewModel.errorMsg.value.isEmpty  {
            XCTAssert(false, "\(viewModel.errorMsg)")
        } else if let movieTitle = viewModel.movieDetails.value.title {
            XCTAssert(true, "Fetch \(String(describing: movieTitle)) movie details")
        } else {
            XCTAssert(true, "Not Fetch movie details")
        }
       
    }
    
}
