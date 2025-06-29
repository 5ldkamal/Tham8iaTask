//
//  RequestAction.swift
//  NetworkLayer
//
//  Created by Khaled Kamal on 08/09/2023.
//

import Combine
import Foundation

protocol RequestAction {
    func request<T: Decodable>(for endPoint: EndPoint,
                               decoder: JSONDecoder,
                               responseValidation: HttpResponseValidation,
                               completion: @escaping (Result<T, Error>) -> Void)

    func requestPublisher<T: Decodable>(for url: URL,
                                        decoder: JSONDecoder,
                                        responseValidation: HttpResponseValidation) -> AnyPublisher<T, Error>

    func requestPublisher<T: Decodable>(for endPoint: EndPoint,
                                        decoder: JSONDecoder,
                                        responseValidation: HttpResponseValidation) -> AnyPublisher<T, Error>

    func requestAsync<T: Decodable>(for endPoint: EndPoint,
                                    decoder: JSONDecoder,
                                    responseValidation: HttpResponseValidation) async throws -> T
}
