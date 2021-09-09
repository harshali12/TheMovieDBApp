//
//  GenresCollectionViewCell.swift
//  MovieApp
//
//  Created by APPLE on 09/09/21.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var genresLbl: UILabel!
    
    //MARK:- ReuseIdentifier
    static let reuseIdentifier = "GenresCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
