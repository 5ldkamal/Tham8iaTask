//
//  RequestAction.swift
//  NetworkLayer
//
//  Created by Khaled Kamal on 08/09/2023.
//

import Combine
import Foundation

protocol RequestAction {
    func request<T: Decodable>(
        for endPoint: EndPoint,
        decoder: JSONDecoder,
        responseValidation: HttpResponseValidation,
        completion: @escaping (Result<T, Error>) -> Void
    )

    func requestPublisher<T: Decodable>(
        for url: URL,
        decoder: JSONDecoder,
        responseValidation: HttpResponseValidation
    ) -> AnyPublisher<T, Error>

    func requestPublisher<T: Decodable>(
        for endPoint: EndPoint,
        decoder: JSONDecoder,
        responseValidation: HttpResponseValidation
    ) -> AnyPublisher<T, Error>

    func requestAsync<T: Decodable>(
        for endPoint: EndPoint,
        decoder: JSONDecoder,
        responseValidation: HttpResponseValidation
    ) async throws -> T
}

extension RequestAction {
    func request<T: Decodable>(
        for _: EndPoint,
        decoder _: JSONDecoder = JSONDecoder(),
        responseValidation _: HttpResponseValidation,
        completion _: @escaping (Result<T, Error>) -> Void
    ) {
        // Default implementation, optionally call something or leave empty.
        // If this needs to be implemented, you'd override it in conforming types.
    }

    func requestPublisher<T: Decodable>(
        for _: URL,
        decoder _: JSONDecoder = JSONDecoder(),
        responseValidation _: HttpResponseValidation
    ) -> AnyPublisher<T, Error> {
        // Default fallback if no override is provided
        return Fail(error: NSError(domain: "RequestAction", code: -2, userInfo: [NSLocalizedDescriptionKey: "Not implemented"]))
            .eraseToAnyPublisher()
    }

    func requestPublisher<T: Decodable>(
        for _: EndPoint,
        decoder _: JSONDecoder = JSONDecoder(),
        responseValidation _: HttpResponseValidation
    ) -> AnyPublisher<T, Error> {
        return Fail(
            error: NSError(
                domain: "RequestAction",
                code: -2,
                userInfo: [NSLocalizedDescriptionKey: "Not implemented"]
            )
        )
        .eraseToAnyPublisher()
    }

    func requestAsync<T: Decodable>(
        for _: EndPoint,
        decoder _: JSONDecoder = JSONDecoder(),
        responseValidation _: HttpResponseValidation
    ) async throws -> T {
        throw NSError(domain: "RequestAction", code: -2, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }
}
