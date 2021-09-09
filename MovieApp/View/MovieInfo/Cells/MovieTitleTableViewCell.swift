//
//  MovieTitleTableViewCell.swift
//  MovieApp
//
//  Created by APPLE on 09/09/21.
//

import UIKit

class MovieTitleTableViewCell: UITableViewCell {

    //MARK:- ReuseIdentifier
    static let reuseIdentifier = "MovieTitleTableViewCell"
    
    //MARk:- IBOutlet
    @IBOutlet weak var movieDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
