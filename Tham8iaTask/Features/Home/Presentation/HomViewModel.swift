//
//  HomViewModel.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    var logger: ErrorLoggerProtocol = ErrorLogger.shared

    @Published var paginationStatus: PaginationStatus = .idle
    @Published var listState: ViewState<[SectionContent]> = .idle

    private var sections: [SectionContent] = []
    private var lastSeenSection: SectionContent? = nil
    private var currentPage = 1
    private var pageSize = 10
    private var totalPages = 0
    private var canLoadMore = true

    private let useCase: HomeUseCaseProtocol

    init(useCase: HomeUseCaseProtocol = HomeUseCase()) {
        self.useCase = useCase
    }

    func fetchData() {
        listState = .loading
        canLoadMore = false
        // Reset pagination state for fresh data fetch
        currentPage = 1
        sections = []

        Task {
            do {
                let homeData = try await self.useCase.fetchHome(for: currentPage)
                let uiSections = (homeData.sections ?? []).map {
                    $0.mapToPresentationModel()
                }
                let totalPages = homeData.pagination?.totalPages ?? 0

                await MainActor.run {
                    listState = uiSections.isEmpty ? .empty(.default()) : .loaded(uiSections)
                    paginationStatus = currentPage >= totalPages ? .endReached : .idle
                    self.sections = uiSections
                    self.totalPages = totalPages
                    canLoadMore = true
                }

            } catch {
                logger.log(error: "\(#function) Error:" + error.localizedDescription)
                await MainActor.run {
                    listState = .error(error.localizedDescription)
                    canLoadMore = true // Reset canLoadMore on error
                }
            }
        }
    }

    func updateLastSeenSection(_ section: SectionContent) {
        lastSeenSection = section
    }

    func loadNextPage(afterSection section: SectionContent) {
        guard sections.last?.id == section.id,
              paginationStatus == .idle,
              canLoadMore
        else {
            return
        }

        paginationStatus = .loading

        Task {
            do {
                let nextPage = currentPage + 1
                let nextData = try await useCase.fetchHome(for: nextPage)

                let newSections = (nextData.sections ?? []).map {
                    $0.mapToPresentationModel()
                }

                await MainActor.run {
                    let totalUISections = sections + newSections
                    self.sections = totalUISections
                    self.listState = .loaded(totalUISections)
                    self.currentPage = nextPage
                    self.totalPages = nextData.pagination?.totalPages ?? 0
                    paginationStatus = currentPage >= totalPages ? .endReached : .idle
                }

            } catch {
                logger.log(error: "\(#function) Error:" + error.localizedDescription)

                await MainActor.run {
                    paginationStatus = .error("Failed to load next page")
                }
            }
        }
    }
}
