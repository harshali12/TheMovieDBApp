//
//  ViewController.swift
//  MovieApp
//
//  Created by APPLE on 07/09/21.
//

import UIKit
import ProgressHUD

class MovieListingViewController: UIViewController {

    //MARK:- IBoutlets
    @IBOutlet weak var tblView: UITableView!
    
    //MARK:- MovieInfoViewModel
    fileprivate var movieInfoVM = MovieInfoViewModel(apiClient: MovieInfoService())
    var errorMesg: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindMovieData()
        // Do any additional setup after loading the view.
    }

    //MARK:- Configure UI
    private func setUpUI() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: MoviePosterImgTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MoviePosterImgTableViewCell.reuseIdentifier)
        movieInfoVM.callMovieListAPI()
        self.title = ScreenText.kMovies.rawValue
    }
    
    //MARK:- Bind Data
    private func bindMovieData() {
        movieInfoVM.movieList.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
        
        movieInfoVM.state.bind { [weak self] (status) in
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
extension MovieListingViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfoVM.movieList.value.count > 10 ? 10 : movieInfoVM.movieList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: MoviePosterImgTableViewCell.reuseIdentifier) as? MoviePosterImgTableViewCell else { return UITableViewCell() }
        if let img = movieInfoVM.movieList.value[indexPath.row].image {
            cell.configureImg(imgURLStr: ("\(NetworkConstants.imagesBaseURL)\(img)"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = movieInfoVM.movieList.value[indexPath.row].id else {
            return
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        vc.movieInfoId = id
        vc.movieInfoVM = movieInfoVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


