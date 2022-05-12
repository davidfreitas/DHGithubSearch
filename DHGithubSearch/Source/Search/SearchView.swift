//
//  SearchView.swift
//  DHGithubSearch
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation
import UIKit

final class SearchView: UIView {
    private let headerLabel: UILabel = {
        let label = UILabel.headline1Label
        label.text = "Repository library"
        return label
    }()
    
    let searchTextField = SearchTextField()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(headerLabel)
        addSubview(searchTextField)
        addSubview(collectionView)
        defineLayout()
        setupGestureRecognizer()
    }
    
    private func defineLayout() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 74),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            searchTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 46),
            
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleTap() {
        endEditing(true)
    }
}

// MARK: - Collection view layout
extension SearchView {
    private static func makeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(42  ))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let section = NSCollectionLayoutSection(group: .horizontal(layoutSize: itemSize, subitems: [item]))
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 12
        return UICollectionViewCompositionalLayout(section: section)
    }
}
