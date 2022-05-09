//
//  Assets.swift
//  DHGithubSearch
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation
import UIKit

struct Asset {
    enum Color {
        case athensGray
        case avatarBackground
        case manatee
        case petrol
        
        var color: UIColor {
            switch self {
            case .athensGray:
                return UIColor(named: "Athens Gray") ?? .lightGray
            case .avatarBackground:
                return UIColor(named: "Avatar Background") ?? .lightGray
            case .petrol:
                return UIColor(named: "Petrol") ?? .black
            case .manatee:
                return UIColor(named: "Manatee") ?? .gray
            }
        }
    }
    
    enum Font {
        case sfProSemibold(size: CGFloat)
        
        var font: UIFont {
            switch self {
            case .sfProSemibold(let size):
                return UIFont(name: "SFProDisplay-Semibold", size: size) ?? .systemFont(ofSize: size)
            }
        }
    }
}
