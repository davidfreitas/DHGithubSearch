//
//  Owner.swift
//  
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

public struct Owner: Decodable {
    public let login: String
    public let avatarUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login = try container.decode(String.self, forKey: .login)
        
        if let avatarUrlString = try container.decode(String?.self, forKey: .avatarUrl) {
            avatarUrl = URL(string: avatarUrlString)
        } else {
            avatarUrl = nil
        }
    }
}

