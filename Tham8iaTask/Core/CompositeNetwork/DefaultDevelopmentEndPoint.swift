//
//  DefaultDevelopmentEndPoint.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

extension EndPoint {
    var host: String {
        return "api-v2-b2sit6oh3a-uc.a.run.app"
    }

    var urlBuilder: URLBuilderProtocol {
        return URLBuilder.development(path: urlPath, host: host)
    }

    var httpMethod: HTTPMethod { .get }

    var parameter: Parameters? { nil }

    var endPointKind: EndPointKind { EndPointKindType.default }
}

/*
 This method is helper u can ignore it as u want
 */
extension URLBuilder {
    static func development(path: String, host: String, queryItems: [URLQueryItem] = []) -> URLBuilder {
        return URLBuilder(path: "/" + path, host: host, queryItems: queryItems)
    }
}
