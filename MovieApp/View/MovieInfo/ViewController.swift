//
//  ViewController.swift
//  MovieApp
//
//  Created by APPLE on 07/09/21.
//

import UIKit

class MovieListingViewController: UIViewController {

    //MARK:- IBoutlets
    @IBOutlet weak var tblView: UITableView!
    
    //MARK:- MovieInfoViewModel
    private var movieInfoVM = MovieInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindMovieData()
        // Do any additional setup after loading the view.
    }

    private func bindMovieData() {
        movieInfoVM.callMovieListAPI()
        movieInfoVM.movieList.bind { [weak self] (movie) in
            print("movies are \(movie)")
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
    }

}


