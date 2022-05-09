//
//  GithubAPI.swift
//
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation
import HTTPClient

public class GithubAPI {
    private static let baseURL = URL(string: "https://api.github.com")!
    private let httpClient: HTTPClient
    
    public convenience init() {
        let httpRequester = URLSessionRequester()
        let httpClient = HTTPClient(baseURL: Self.baseURL, requester: httpRequester)
        self.init(httpClient: httpClient)
    }
    
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    public func searchRepositories(withQuery query: String) async throws -> [Repository] {
        let endpoint = Endpoint.searchRepository(query: query)
        let result: RepositorySearchResult = try await httpClient.get(path: endpoint.path, queryItems: endpoint.queryItems, headers: endpoint.headers)
        return result.items
    }
}
