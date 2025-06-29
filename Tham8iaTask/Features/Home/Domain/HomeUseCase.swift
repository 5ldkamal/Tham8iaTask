//
//  HomeUseCase.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

protocol HomeUseCaseProtocol {
    func fetchHome(for page: Int) async throws -> HomeDTO
}

struct HomeUseCase: HomeUseCaseProtocol {
    var network: RequestAction = URLSession.shared

    func fetchHome(for page: Int) async throws -> HomeDTO {
        return try await network.requestAsync(for: HomeEndpoint(page: page),
                                              decoder: .init(),
                                              responseValidation: HttpResponseValidator())
    }
}

// MARK: - EndPoint

extension HomeUseCase {
    private struct HomeEndpoint: EndPoint {
        let page: Int
        var urlPath: String { "home_sections" }
        var parameter: Parameters? {
            return ["page": page]
        }
    }
}
