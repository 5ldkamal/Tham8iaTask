//
//  URLComponents.swift
//  NetworkLayer
//
//  Created by Khaled Kamal on 08/09/2023.
//

import Foundation

protocol URLBuilderProtocol {
    var url: URL? { get }
}

/// Build the http url
struct URLBuilder: URLBuilderProtocol {
    let path: String
    let host: String
    let queryItems: [URLQueryItem]

    ///
    /// - Parameters:
    ///   - path: the path of wanted method
    ///   - host: the api hosting
    init(path: String, host: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.host = host
        self.queryItems = queryItems
    }

    /// return the Optional(Url)
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components.url
    }
}

// MARK: - URL

extension URL: URLBuilderProtocol {
    var url: URL? {
        return self
    }
}

extension String: URLBuilderProtocol {
    var url: URL? {
        return URL(string: self)
    }
}
