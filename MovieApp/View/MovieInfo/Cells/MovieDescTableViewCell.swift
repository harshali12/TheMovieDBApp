//
//  MovieDescTableViewCell.swift
//  MovieApp
//
//  Created by APPLE on 08/09/21.
//

import UIKit
import Kingfisher

class MovieDescTableViewCell: UITableViewCell {

    //MARK:- reuseIdentifier
    static let reuseIdentifier = "MovieDescTableViewCell"
    
    //MARK:- IBOutlets
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieDescLbl: UILabel!
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstant: NSLayoutConstraint!
    
    var genresArr : [GenresModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            self.collectionHeightConstant.constant = height
            self.layoutSubviews()
        }
    }

    private func setUpUI() {
        collectionView.register(UINib(nibName: GenresCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: GenresCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func bindData(data: MovieDetailModel) {
        movieDescLbl.text = data.overview ?? ""
        if let imgPath = data.poster_path {
            posterImgView.kf.setImage(with: URL(string: "\(NetworkConstants.imagesBaseURL)\(imgPath)"))
        }
        rateLbl.text = "\(String(describing: data.popularity ?? 0.0))"
        movieTitleLbl.text = data.title ?? ""
        genresArr = data.genres
    }

}

//MARK:- UICollectionViewDataSource, UICollectionViewDelegate Methods
extension MovieDescTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCollectionViewCell
                                                            .reuseIdentifier, for: indexPath) as? GenresCollectionViewCell else {
        return UICollectionViewCell()
       }
        cell.genresLbl.text = genresArr?[indexPath.row].name ?? ""
        
        return cell
    }
    
    
        
}
