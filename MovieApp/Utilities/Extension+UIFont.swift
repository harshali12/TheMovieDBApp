//
//  Extension+UIFont.swift
//  MovieApp
//
//  Created by APPLE on 09/09/21.
//

import Foundation
import UIKit

extension UIFont {
    
    enum AmericanTypewriter: String {
        case typewriter = "AmericanTypewriter"
        case bold = "AmericanTypewriter-Bold"
        case semiBold = "AmericanTypewriter-Semibold"
        case regular = "Regular"
        case condensed = "AmericanTypewriter-Condensed"
        case condensedBold = "AmericanTypewriter-CondensedBold"
        case condensedLight = "AmericanTypewriter-CondensedLight"
        case light = "AmericanTypewriter-Light"
        
        static func AmericanTypewriter(_ type: AmericanTypewriter = .typewriter, size: CGFloat = UIFont.systemFontSize) -> UIFont {
            return UIFont(name: "\(type.rawValue)", size: size)!
        }
    }
    
}
