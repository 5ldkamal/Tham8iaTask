//
//  RequestAction+URLSession.swift
//  NetworkLayer
//
//  Created by Khaled Kamal on 08/09/2023.
//

import Combine
import Foundation

extension URLSession: RequestAction {
    func request<T: Decodable>(for endPoint: EndPoint, decoder: JSONDecoder, responseValidation: HttpResponseValidation, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endPoint.url else {
            completion(.failure(InvalidURLError(url: endPoint.url)))
            return
        }

        let task = dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data, let response = response {
                do {
                    let validation = try responseValidation.validate(output: (data, response))
                    let model = try decoder.decode(T.self, from: validation.data)
                    completion(.success(model))

                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func requestPublisher<T>(for endPoint: EndPoint,
                             decoder: JSONDecoder,
                             responseValidation _: HttpResponseValidation) -> AnyPublisher<T, Error> where T: Decodable
    {
        guard let url = endPoint.url else {
            return Fail(error: InvalidURLError(url: endPoint.url))
                .eraseToAnyPublisher()
        }
        return requestPublisher(for: url, decoder: decoder)
    }

    func requestPublisher<T>(for url: URL,
                             decoder: JSONDecoder,
                             responseValidation: HttpResponseValidation = HttpResponseValidator.default()) -> AnyPublisher<T, Error> where T: Decodable
    {
        dataTaskPublisher(for: url)
            .tryMap { try responseValidation.validate(output: $0) }
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

    func requestAsync<T>(for endPoint: EndPoint,
                         decoder: JSONDecoder,
                         responseValidation responseHandler: HttpResponseValidation = HttpResponseValidator.default()) async throws -> T where T: Decodable
    {
        let request = try endPoint.asURLRequest()
        let response = try await data(for: request)
        let validator = try responseHandler.validate(output: response)
        return try decoder.decode(T.self, from: validator.data)
    }
}

/*
 let ser =  try JSONSerialization.jsonObject(with: validator.data)
 print(ser)
 */
