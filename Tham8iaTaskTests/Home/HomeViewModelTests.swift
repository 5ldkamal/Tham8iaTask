//
//  HomeViewModelTests.swift
//  Tham8iaTaskTests
//
//  Created by Khaled Kamal on 30/06/2025.
//

import Combine
@testable import Tham8iaTask
import XCTest

final class HomeViewModelTests: XCTestCase {
    // MARK: - Test Dependencies

    private var viewModel: HomeViewModel!
    private var mockUseCase: MockHomeUseCase!
    private var mockLogger: MockErrorLogger!

    // MARK: - Setup & Teardown

    override func setUp() {
        super.setUp()
        mockUseCase = MockHomeUseCase()
        mockLogger = MockErrorLogger()
        viewModel = HomeViewModel(useCase: mockUseCase, logger: mockLogger)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockLogger = nil
        super.tearDown()
    }

    // MARK: - Initial State Tests

    func testInitialState() {
        // Given & When - ViewModel is initialized

        // Then
        XCTAssertEqual(viewModel.listState, .idle)
        XCTAssertEqual(viewModel.paginationStatus, .idle)
    }

    // MARK: - Fetch Data Tests

    func testFetchData_Success_EmptyResponse() async throws {
        // Given
        let emptyHomeData = HomeDTO(sections: [], pagination: nil)
        mockUseCase.fetchHomeResult = .success(emptyHomeData)

        // When
        await viewModel.fetchData()

        // Small delay to ensure first task starts
        try await Task.sleep(nanoseconds: 10_000_000) // 10ms

        // Then
        XCTAssertEqual(viewModel.listState, .empty(.default()))
        XCTAssertEqual(viewModel.paginationStatus, .endReached)
        XCTAssertEqual(mockUseCase.fetchHomeCallCount, 1)
        XCTAssertEqual(mockUseCase.lastFetchedPage, 1)
    }

    func testFetchData_Success_WithSections() async throws {
        // Given
        let homeData = HomeDTOMockupData.shared.getHomeDTO()
        mockUseCase.fetchHomeResult = .success(homeData)

        // When
        await viewModel.fetchData()

        // Small delay to ensure first task starts
        try await Task.sleep(nanoseconds: 10_000_000) // 10ms

        // Then
        if case let .loaded(loadedSections) = viewModel.listState {
            XCTAssertEqual(loadedSections.count, 1)
        } else {
            XCTFail("Expected loaded state with sections")
        }
        XCTAssertEqual(viewModel.paginationStatus, .idle)
    }
}

// MARK: - Mock Dependencies

final class MockHomeUseCase: HomeUseCaseProtocol {
    var fetchHomeResult: Result<HomeDTO, Error> = .success(HomeDTO(sections: [], pagination: nil))
    var fetchHomeCallCount: Int = 0
    var lastFetchedPage: Int = 0

    func fetchHome(for page: Int) async throws -> HomeDTO {
        fetchHomeCallCount += 1
        lastFetchedPage = page

        switch fetchHomeResult {
        case let .success(homeData):
            return homeData
        case let .failure(error):
            throw error
        }
    }
}

final class MockErrorLogger: ErrorLoggerProtocol {
    var failure: Error?
    func log(error: any Error) {
        failure = error
    }
}
