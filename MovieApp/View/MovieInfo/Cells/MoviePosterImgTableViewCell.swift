//
//  MoviePosterImgTableViewCell.swift
//  MovieApp
//
//  Created by APPLE on 08/09/21.
//

import UIKit
import Kingfisher

class MoviePosterImgTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    //MARK:- reuseIdentifier
    static let reuseIdentifier = "MoviePosterImgTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }

    private func setUpUI() {
        posterImgView.applyshadowWithCorner(containerView: bgView, cornerRadious: 10)
    }
    
    func configureImg(imgURLStr: String) {
        posterImgView.kf.setImage(with: URL(string: imgURLStr))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
