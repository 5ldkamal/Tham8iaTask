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

    @Published var listState: ViewState<[SectionContent]> = .idle

    private let useCase: HomeUseCaseProtocol

    init(useCase: HomeUseCaseProtocol = HomeUseCase()) {
        self.useCase = useCase
    }

    func fetchData() {
        listState = .loading

        Task {
            do {
                let uiSections = try await (self.useCase.fetchHome().sections ?? []).map {
                    $0.mapToPresentationModel()
                }

                await MainActor.run {
                    listState = uiSections.isEmpty ? .empty(.default()) : .loaded(uiSections)
                }

            } catch {
                logger.log(error: "\(#function) Error:" + error.localizedDescription)
                await MainActor.run {
                    listState = .error(error.localizedDescription)
                }
            }
        }
    }
}
