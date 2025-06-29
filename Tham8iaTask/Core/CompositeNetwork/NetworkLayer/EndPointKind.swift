//
//  EndPointKind.swift
//  NetworkLayer
//
//  Created by Khaled Kamal on 08/09/2023.
//

import Foundation

protocol EndPointKind {
    func prepareURLRequest(urlRequest: inout URLRequest)
}

enum EndPointKindType: EndPointKind {
    case `default`
    case `private`([String: String?])

    func prepareURLRequest(urlRequest: inout URLRequest) {
        switch self {
        case let .private(headers):
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }

        case .default:
            break
        }
    }
}
