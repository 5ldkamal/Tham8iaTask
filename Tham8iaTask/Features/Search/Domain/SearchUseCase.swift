//
//  SearchUseCase.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

protocol SearchUseCaseProtocol {
    func search(word: String) async throws -> SearchDTO
}

struct SearchUseCase: SearchUseCaseProtocol {
    var network: RequestAction = URLSession.shared

    func search(word: String) async throws -> SearchDTO {
        return try await network.requestAsync(for: SearchEndpoint(word: word),
                                              decoder: .init(),
                                              responseValidation: HttpResponseValidator())
    }
}

// MARK: - EndPoint

extension SearchUseCase {
    private struct SearchEndpoint: EndPoint {
        var host: String {
            return "mock.apidog.com"
        }

        var urlPath: String { "/m1/735111-711675-default/search" }

        var urlBuilder: any URLBuilderProtocol {
            URLBuilder(path: urlPath, host: host, queryItems: [])
        }

        var parameter: Parameters? {
            ["word": word]
        }

        let word: String

        init(word: String) {
            self.word = word
        }
    }
}
