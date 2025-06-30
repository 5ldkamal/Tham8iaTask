//
//  HomeViewModel.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    // MARK: - Dependencies

    private let logger: ErrorLoggerProtocol
    private let useCase: HomeUseCaseProtocol

    // MARK: - Published Properties

    @Published private(set) var listState: ViewState<[SectionContent]> = .idle
    @Published private(set) var paginationStatus: PaginationStatus = .idle

    // MARK: - Private State

    private var sections: [SectionContent] = []
    private var lastSeenSection: SectionContent?
    private var paginationInfo = PaginationInfo()

    // MARK: - Task Management

    private var fetchTask: Task<Void, Never>?
    private var loadMoreTask: Task<Void, Never>?

    // MARK: - Initialization

    init(
        useCase: HomeUseCaseProtocol = HomeUseCase(),
        logger: ErrorLoggerProtocol = ErrorLogger.shared
    ) {
        self.useCase = useCase
        self.logger = logger
    }

    deinit {
        cancelAllTasks()
    }
}

// MARK: - Public Interface

extension HomeViewModel {
    func fetchData() async {
        cancelAllTasks()

        await resetState()

        fetchTask = Task {
            await performFetch(isRefresh: true)
        }
    }

    func loadNextPage(for section: SectionContent) {
        guard shouldLoadMore(for: section) else { return }

        loadMoreTask = Task { @MainActor in
            await performFetch(isRefresh: false)
        }
    }

    func updateLastSeenSection(_ section: SectionContent) {
        lastSeenSection = section
    }

    func retry() {
        Task {
            await fetchData()
        }
    }
}

// MARK: - Private Methods

private extension HomeViewModel {
    @MainActor
    func resetState() {
        // Keep existing data visible during refresh
        if case .loaded = listState {
            // Don't change listState to .loading to keep data visible
        } else {
            listState = .loading
        }
        paginationStatus = .idle
        // Don't clear sections - keep them for pull-to-refresh UX
        paginationInfo.reset()
    }

    func shouldLoadMore(for section: SectionContent) -> Bool {
        guard sections.last?.id == section.id,
              paginationStatus == .idle,
              paginationInfo.canLoadMore
        else {
            return false
        }
        return true
    }

    func cancelAllTasks() {
        fetchTask?.cancel()
        loadMoreTask?.cancel()
    }

    func performFetch(isRefresh: Bool) async {
        await MainActor.run {
            if !isRefresh {
                paginationStatus = .loading
            }
        }

        do {
            let targetPage = isRefresh ? 1 : paginationInfo.nextPage
            let homeData = try await useCase.fetchHome(for: targetPage)
            await handleFetchSuccess(homeData, isRefresh: isRefresh)
        } catch {
            await handleFetchError(error, isRefresh: isRefresh)
        }
    }

    @MainActor
    func handleFetchSuccess(_ homeData: HomeDTO, isRefresh: Bool) {
        let newSections = homeData.sections?.compactMap { $0.mapToPresentationModel() } ?? []

        if isRefresh {
            // Replace sections with fresh data for refresh
            sections = newSections
        } else {
            // Append for pagination
            sections.append(contentsOf: newSections)
        }

        paginationInfo.update(
            currentPage: isRefresh ? 1 : paginationInfo.nextPage,
            totalPages: homeData.pagination?.totalPages ?? 0
        )

        updateUIState()
    }

    @MainActor
    func handleFetchError(_ error: Error, isRefresh: Bool) {
        logger.log(error: "\(#function) Error: \(error.localizedDescription)")

        if isRefresh {
            listState = .error(error.localizedDescription)
        } else {
            paginationStatus = .error("Failed to load next page")
        }
    }

    @MainActor
    func updateUIState() {
        listState = sections.isEmpty ? .empty(.default()) : .loaded(sections)
        paginationStatus = paginationInfo.hasReachedEnd ? .endReached : .idle
    }
}
