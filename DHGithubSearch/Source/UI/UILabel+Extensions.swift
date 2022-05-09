//
//  UILabel+Extensions.swift
//  DHGithubSearch
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation
import UIKit

extension UILabel {
    static var headline1Label: UILabel {
        Self.create(withFont: Asset.Font.sfProSemibold(size: 20).font,
                           color: Asset.Color.petrol.color)
    }
    
    static var titleLabel: UILabel {
        Self.create(withFont: Asset.Font.sfProSemibold(size: 16).font,
                           color: Asset.Color.petrol.color)
    }
    
    static var subtitleLabel: UILabel {
        Self.create(withFont: Asset.Font.sfProSemibold(size: 14).font,
                           color: Asset.Color.petrol.color)
    }
    
    private static func create(withFont font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
