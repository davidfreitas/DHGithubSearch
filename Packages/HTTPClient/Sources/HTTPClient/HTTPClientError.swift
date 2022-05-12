//
//  HTTPClientError.swift
//  
//
//  Created by David Freitas on 08/05/2022.
//

import Foundation

public enum HTTPClientError: Error {
    case forbidden
    case notFound
    case unknown
}
