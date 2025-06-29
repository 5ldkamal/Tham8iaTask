//
//  HomeUseCase.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

protocol HomeUseCaseProtocol {
    func fetchHome() async throws -> HomeDTO
}

struct HomeUseCase: HomeUseCaseProtocol {
    var network: RequestAction = URLSession.shared

    func fetchHome() async throws -> HomeDTO {
        return try await network.requestAsync(for: HomeEndpoint(),
                                              decoder: .init(),
                                              responseValidation: HttpResponseValidator())
    }
}

// MARK: - EndPoint

extension HomeUseCase {
    private struct HomeEndpoint: EndPoint {
        var urlPath: String { "home_sections" }
    }
}
