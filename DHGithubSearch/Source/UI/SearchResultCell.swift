//
//  SearchResultCell.swift
//  DHGithubSearch
//
//  Created by David Freitas on 09/05/2022.
//

import Foundation
import UIKit

final class SearchResultCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: SearchResultCell.self)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = UILabel.titleLabel
    private let subtitleLabel = UILabel.subtitleLabel
    
    private var imageTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        resetImageView()
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        defineLayout()
    }
    
    private func defineLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            subtitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        imageTask?.cancel()
        guard let imageURL = viewModel.imageURL else {
            resetImageView()
            return
        }
        
        downloadImage(url: imageURL)
    }
    
    private func downloadImage(url: URL) {
        let imageTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                self?.resetImageView()
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        self.imageTask = imageTask
        imageTask.resume()
    }
    
    private func resetImageView() {
        imageView.backgroundColor = Asset.Color.avatarBackground.color
        imageView.image = UIImage(named: "default_icon")
    }
}

extension SearchResultCell {
    struct ViewModel: Hashable {
        let title: String
        let subtitle: String?
        let imageURL: URL?
    }
}
