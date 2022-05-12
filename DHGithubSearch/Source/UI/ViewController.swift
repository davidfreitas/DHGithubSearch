//
//  ViewController.swift
//  DHGithubSearch
//
//  Created by David Freitas on 09/05/2022.
//

import Foundation
import UIKit

class ViewController<V: UIView>: UIViewController {
    let contentView: V
    
    init() {
        contentView = V()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
}
