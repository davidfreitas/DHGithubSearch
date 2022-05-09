//
//  HTTPRequester.swift
//  
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

public typealias HTTPRequesterResponse = (data: Data, statusCode: Int)

public protocol HTTPRequester {
    func get(baseURL: URL, path: String, queryItems: [URLQueryItem], headers: [String: String]) async throws -> HTTPRequesterResponse
}
