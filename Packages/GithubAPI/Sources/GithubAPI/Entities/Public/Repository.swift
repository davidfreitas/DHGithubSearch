//
//  Repository.swift
//  DHGithubSearch
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

public struct Repository: Decodable {
    public let id: Int
    public let name: String
    public let owner: Owner
    public let description: String?
    public let openIssuesCount: Int
    public let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case description
        case openIssuesCount = "open_issues_count"
        case language
    }
}
