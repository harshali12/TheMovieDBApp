//
//  MovieDetailSection.swift
//  MovieApp
//
//  Created by APPLE on 09/09/21.
//

import Foundation
import UIKit

enum MovieDetailsSection {
    case MovieTitle
    case MoviePoster
    case Rating
    case Genres
    case Languages
    case Overview
    
    var title: String {
        switch self {
        case .Genres:
            return "Genres"
        case .Languages:
            return "Languages"
        case .Overview:
            return "Overview"
        default:
            return ""
        }
    }
    
    var hideHeader: Bool {
        switch self {
        case .Genres,.Languages,.Overview:
            return false
        default:
            return true
        }
    }
    
    var rowsCount: Int {
        switch self {
        default:
            return 1
        }
    }
    
    var txtFont: UIFont {
        switch self {
        case .MovieTitle:
            return UIFont.AmericanTypewriter.AmericanTypewriter(.bold, size: 18)
        case .Rating:
            return UIFont.AmericanTypewriter.AmericanTypewriter(.semiBold, size: 16)
        default:
            return UIFont.AmericanTypewriter.AmericanTypewriter(.semiBold, size: 14)
        }
    }
    
}


