//
//  HomViewModel.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    var logger: ErrorLoggerProtocol = ErrorLogger.shared

    @Published var sections: [SectionContent] = []

    private let useCase: HomeUseCaseProtocol

    init(useCase: HomeUseCaseProtocol = HomeUseCase()) {
        self.useCase = useCase
    }

    func fetchData() {
        Task {
            do {
                let uiSections = try await (self.useCase.fetchHome().sections ?? []).map {
                    $0.mapToPresentationModel()
                }

                await MainActor.run {
                    sections = uiSections
                }

            } catch {
                logger.log(error: "\(#function) Error:" + error.localizedDescription)
            }
        }
    }
}
