//
//  Endpoint.swift
//  
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

enum Endpoint {
    case searchRepository(query: String)
    
    var path: String {
        switch self {
        case .searchRepository:
            return "search/repositories"
        }
    }
    
    var method: String {
        switch self {
        case .searchRepository:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchRepository(let query):
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return [URLQueryItem(name: "q", value: encodedQuery)]
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .searchRepository:
            return [:]
        }
    }
}
