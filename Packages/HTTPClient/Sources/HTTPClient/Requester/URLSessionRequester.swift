//
//  URLSessionRequester.swift
//
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

public final class URLSessionRequester: HTTPRequester {
    public init() {}
    
    public func get(baseURL: URL, path: String, queryItems: [URLQueryItem], headers: [String: String]) async throws -> HTTPRequesterResponse {
        let request = URLRequest.create(
            url: baseURL.appendingPathComponent(path),
            method: "GET",
            queryItems: queryItems,
            body: nil,
            headers: headers
        )
        
        return try await performRequest(request)
    }
    
    private func performRequest(_ request: URLRequest) async throws -> HTTPRequesterResponse {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw HTTPRequesterError.unknown
            }
            
            return (data: data, statusCode: response.statusCode)
        } catch {
            throw error
        }
    }
}

private extension URLRequest {
    static func create(url: URL, method: String, queryItems: [URLQueryItem] = [], body: Data?, headers: [String: String]) -> URLRequest {
        let augmentedURL: URL
        if !queryItems.isEmpty {
            var comps = URLComponents(url: url, resolvingAgainstBaseURL: false)
            comps?.queryItems = queryItems
            augmentedURL = comps?.url ?? url
        } else {
            augmentedURL = url
        }
        
        var request = URLRequest(url: augmentedURL)
        request.httpMethod = method
        
        if let data = body {
            request.httpBody = data
        }
        
        for (headerField, value) in headers {
            request.addValue(value, forHTTPHeaderField: headerField)
        }
        
        return request
    }
}
