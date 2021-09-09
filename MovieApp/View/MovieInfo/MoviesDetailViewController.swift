//
//  MoviesDetailViewController.swift
//  MovieApp
//
//  Created by APPLE on 08/09/21.
//

import UIKit
import ProgressHUD

class MoviesDetailViewController: UIViewController {

    //MARK:- IBoutlets
    @IBOutlet weak var tblView: UITableView!
    
    var movieInfoId = 0
    var movieInfoVM: MovieInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }

    private func setUpUI() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.tableFooterView = UIView()
        tblView.estimatedRowHeight = 60.0
        registerNibs()
        movieInfoVM?.callMovieDetailsAPI(movieId: movieInfoId)
        bindMovieData()
     }
    
    private func registerNibs() {
        //Table Cells
        tblView.register(UINib(nibName: MoviePosterImgTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MoviePosterImgTableViewCell.reuseIdentifier)
        tblView.register(UINib(nibName: GenresCollectionViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: GenresCollectionViewCell.reuseIdentifier)
        tblView.register(UINib(nibName: MovieRatingTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieRatingTableViewCell.reuseIdentifier)
        tblView.register(UINib(nibName: MovieTitleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieTitleTableViewCell.reuseIdentifier)
        tblView.register(UINib(nibName: MovieDetailCollectionTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieDetailCollectionTableViewCell.reuseIdentifier)

        //Header Footer view
        tblView.register(UINib(nibName: MovieDetailHeaderView.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: MovieDetailHeaderView.reuseIdentifier)
    }
    
    private func bindMovieData() {
        movieInfoVM?.movieDetails.bind { [weak self] (movie) in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
        movieInfoVM?.state.bind { [weak self] (status) in
            switch status {
            case .loading:
                ProgressHUD.show("")
            default:
                ProgressHUD.dismiss()
            }
            
        }
    }

}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension MoviesDetailViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfoVM?.MovieDetailSection[section].rowsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = movieInfoVM?.movieDetails.value else {
            return UITableViewCell()
        }
        
        switch movieInfoVM?.MovieDetailSection[indexPath.section] {
        case .MovieTitle:
            guard let cell = tblView.dequeueReusableCell(withIdentifier: MovieTitleTableViewCell.reuseIdentifier) as? MovieTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.movieDescLbl.font = MovieDetailsSection.MovieTitle.txtFont
            cell.movieDescLbl.text = data.title
            return cell
        case .MoviePoster:
            guard let cell = tblView.dequeueReusableCell(withIdentifier: MoviePosterImgTableViewCell.reuseIdentifier) as? MoviePosterImgTableViewCell else {
                return UITableViewCell()
            }
            if let imgPath = data.poster_path {
                cell.configureImg(imgURLStr: "\(NetworkConstants.imagesBaseURL)\(imgPath)")
            }
            return cell
        case .Rating:
            guard let cell = tblView.dequeueReusableCell(withIdentifier: MovieRatingTableViewCell.reuseIdentifier) as? MovieRatingTableViewCell else {
                return UITableViewCell()
            }
            cell.rateLbl.text = "\(String(describing: data.popularity ?? 0.0))"
            return cell
        case .Genres:
            guard let cell = tblView.dequeueReusableCell(withIdentifier: MovieDetailCollectionTableViewCell.reuseIdentifier) as? MovieDetailCollectionTableViewCell else {
                return UITableViewCell()
            }
            cell.collectionArr = data.genres
            return cell
        case .Languages:
            guard let cell = tblView.dequeueReusableCell(withIdentifier: MovieDetailCollectionTableViewCell.reuseIdentifier) as? MovieDetailCollectionTableViewCell else {
                return UITableViewCell()
            }
            if let spokenLanguages = data.spoken_languages {
                cell.collectionArr = spokenLanguages
            } else if let language = data.original_language {
                cell.collectionArr = [language]
            }
            return cell
        case .Overview:
            guard let cell = tblView.dequeueReusableCell(withIdentifier: MovieTitleTableViewCell.reuseIdentifier) as? MovieTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.movieDescLbl.font = MovieDetailsSection.Overview.txtFont
            cell.movieDescLbl.text = data.overview
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieInfoVM?.MovieDetailSection.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return movieInfoVM?.MovieDetailSection[section].hideHeader ?? true ? 1 : 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tblView.dequeueReusableHeaderFooterView(withIdentifier: MovieDetailHeaderView.reuseIdentifier) as? MovieDetailHeaderView else {
            return UIView()
        }
        headerView.headerSectionTitleLbl.text = movieInfoVM?.MovieDetailSection[section].title ?? ""
        headerView.tintColor = UIColor.clear
        switch movieInfoVM?.MovieDetailSection[section] {
        case .Genres,.Languages,.Overview:
             return headerView
        default:
            return UIView()
        }
    }
    
}
