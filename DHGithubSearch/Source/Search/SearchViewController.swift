//
//  SearchViewController.swift
//  DHGithubSearch
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation
import UIKit

final class SearchViewController: ViewController<SearchView> {
    typealias DataSource = UICollectionViewDiffableDataSource<SearchViewModel.Section, SearchResultCell.ViewModel>
    
    private let viewModel: SearchViewModel
    private lazy var dataSource = makeDataSource()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.reuseIdentifier)
        contentView.searchTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc private func textChanged() {
        guard let text = contentView.searchTextField.text else { return }
        
        Task { @MainActor in
            await viewModel.textFieldChanged(text: text)
            await dataSource.apply(viewModel.makeDataSourceSnapshot())
        }
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: contentView.collectionView) { collectionView, indexPath, viewModel in
            guard let cell: SearchResultCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell else {
                fatalError()
            }
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
}
