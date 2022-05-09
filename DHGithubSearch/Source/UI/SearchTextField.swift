//
//  SearchTextField.swift
//  DHGithubSearch
//
//  Created by David Freitas on 09/05/2022.
//

import Foundation
import UIKit

final class SearchTextField: UIControl {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "search_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Asset.Color.petrol.color
        textField.font = Asset.Font.sfProSemibold(size: 16).font
        textField.placeholder = "Search for repository"
        textField.autocorrectionType = .no
        return textField
    }()
    
    var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        textField.addTarget(target, action: action, for: controlEvents)
    }
    
    private func setup() {
        layer.cornerRadius = 6
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Asset.Color.athensGray.color
        addSubview(textField)
        addSubview(imageView)
        defineLayout()
    }
    
    private func defineLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 19),
            imageView.heightAnchor.constraint(equalToConstant: 18),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
