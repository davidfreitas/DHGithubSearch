//
//  SearchViewModel.swift
//  DHGithubSearch
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation
import GithubAPI
import UIKit

final class SearchViewModel {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, SearchResultCell.ViewModel>
    
    private var repositories: [Repository] = []
    private var searchTask: Task<Void, Never>?
    
    func textFieldChanged(text: String) async {
        searchTask?.cancel()
        guard text.count > 2 else {
            self.repositories.removeAll()
            return
        }
        
        let searchTask = Task {
            do {
                let repositories = try await API.github.searchRepositories(withQuery: text)
                self.repositories = repositories
            } catch {
                print(error)
            }
        }
        self.searchTask = searchTask
        return await searchTask.value
    }
    
    func makeDataSourceSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.repositories])
        let items: [SearchResultCell.ViewModel] = repositories.map {
            .init(title: "\($0.owner.login) / \($0.name)",
                  subtitle: $0.description,
                  imageURL: $0.owner.avatarUrl)
        }
        snapshot.appendItems(items, toSection: .repositories)
        return snapshot
    }
}

extension SearchViewModel {
    enum Section {
        case repositories
    }
}
