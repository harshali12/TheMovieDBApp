//
//  MovieRatingTableViewCell.swift
//  MovieApp
//
//  Created by APPLE on 09/09/21.
//

import UIKit

class MovieRatingTableViewCell: UITableViewCell {
    
    //MARK:- ReuseIdentifier
    static let reuseIdentifier = "MovieRatingTableViewCell"
    
    //MARk:- IBOutlet
    @IBOutlet weak var rateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
