//
//  HTTPClient.swift
//  
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

final class HTTPClient {
    private let baseURL: URL
    private let requester: HTTPRequester
    
    init(baseURL: URL, requester: HTTPRequester) {
        self.baseURL = baseURL
        self.requester = requester
    }
    
    func get<V: Decodable>(path: String, queryItems: [URLQueryItem], headers: [String: String]) async -> Result<V, HTTPClientError> {
        do {
            let result = try await requester.get(baseURL: baseURL, path: path, queryItems: queryItems, headers: headers)
            return .success(try handleRequestResult(result))
        } catch let error as HTTPClientError {
            return .failure(error)
        } catch {
            return .failure(HTTPClientError.unknown)
        }
    }
    
    private func handleRequestResult<V: Decodable>(_ result: HTTPRequesterResponse) throws -> V {
        switch result.statusCode {
        case 200..<300:
            let value = try JSONDecoder().decode(V.self, from: result.data)
            return value
        case 403:
            throw HTTPClientError.forbidden
        case 404:
            throw HTTPClientError.notFound
        default:
            throw HTTPClientError.unknown
        }
    }
}
