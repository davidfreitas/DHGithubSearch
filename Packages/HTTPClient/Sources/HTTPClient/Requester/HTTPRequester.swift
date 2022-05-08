//
//  HTTPRequester.swift
//  
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

typealias HTTPRequesterResponse = (data: Data, statusCode: Int)

protocol HTTPRequester {
    func get(baseURL: URL, path: String, queryItems: [URLQueryItem], headers: [String: String]) async throws -> HTTPRequesterResponse
}
