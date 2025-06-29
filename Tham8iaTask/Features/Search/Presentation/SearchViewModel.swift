//
//  SearchViewModel.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var sections: [SectionContent] = []
    var logger: ErrorLoggerProtocol = ErrorLogger.shared

    let useCase: SearchUseCaseProtocol
    init(useCase: SearchUseCaseProtocol = SearchUseCase()) {
        self.useCase = useCase
    }

    func viewAppeared() {
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.searchQuery(word: text)
            }.store(in: &cancellable)
    }

    private func searchQuery(word: String) {
        Task {
            do {
                let sectionsDTO = try await useCase.search(word: word).sections
                await updateSections(sectionsDTO)

            } catch {
                logger.log(error: error)
                await self.updateSections([])
            }
        }
    }

    @MainActor
    private func updateSections(_ sectionsDTO: [SearchSection]?) {
        sections = (sectionsDTO ?? []).map {
            $0.mapToPresentationModel()
        }
    }
}
