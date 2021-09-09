//
//  MovieDetailCollectionTableViewCell.swift
//  MovieApp
//
//  Created by APPLE on 09/09/21.
//

import UIKit

class MovieDetailCollectionTableViewCell: UITableViewCell {
    
    //MARK:- reuseIdentifier
    static let reuseIdentifier = "MovieDetailCollectionTableViewCell"
    
    //MARK:- IBOutlets
    @IBOutlet weak var collectionView: DynamicHeightCollectionView!
    @IBOutlet weak var collectionHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var flowLayoutCollectionView: UICollectionViewFlowLayout! {
        didSet {
            flowLayoutCollectionView.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var collectionArr : [Any]? {
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

    private func setUpUI() {
        collectionView.register(UINib(nibName: GenresCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: GenresCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
    }
    
}

//MARK:- UICollectionViewDataSource, UICollectionViewDelegate Methods
extension MovieDetailCollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCollectionViewCell
                                                            .reuseIdentifier, for: indexPath) as? GenresCollectionViewCell else {
        return UICollectionViewCell()
       }
        
        if let collectionData = collectionArr as? [GenresModel] {
            cell.genresLbl.text = collectionData[indexPath.row].name ?? ""
        } else if let collectionData = collectionArr as? [SpokenLanguagesModel] {
            cell.genresLbl.text = collectionData[indexPath.row].english_name ?? ""
        } else if let collectionData = collectionArr as? [String] {
            cell.genresLbl.text = collectionData[indexPath.row] 
        } else if let collectionData = collectionArr as? [ProductionCompaniesModel] {
            cell.genresLbl.text = collectionData[indexPath.row].name
        }
        
        return cell
    }
       
}
