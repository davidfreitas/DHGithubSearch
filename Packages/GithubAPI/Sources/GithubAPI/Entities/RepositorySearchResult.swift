//
//  RepositorySearchResult.swift
//  
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

struct RepositorySearchResult: Decodable {
    let count: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case items
    }
}
