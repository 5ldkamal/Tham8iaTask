//
//  HomeUseCaseTests.swift
//  Tham8iaTaskTests
//
//  Created by Khaled Kamal on 30/06/2025.
//

import Combine
@testable import Tham8iaTask
import XCTest

final class HomeUseCaseTests: XCTestCase {
    private var mockRequestAction: MockRequestAction!
    private var homeUseCase: HomeUseCase!

    override func setUpWithError() throws {
        mockRequestAction = MockRequestAction()
        homeUseCase = HomeUseCase(network: mockRequestAction)
    }

    override func tearDownWithError() throws {
        mockRequestAction = nil
        homeUseCase = nil
    }

    func testFetchHomeSuccess() async throws {
        // Arrange

        let homeDTO = HomeDTOMockupData.shared.getHomeDTO()
        mockRequestAction.mockResponse = homeDTO

        // Act
        let result = try await homeUseCase.fetchHome(for: 1)

        // Assert
        XCTAssertEqual(result.sections?.count, homeDTO.sections?.count)
    }

    func testFetchHomeFailure() async throws {
        // Arrange
        let failure: Error = "Network Error"
        mockRequestAction.mockError = failure

        do {
            let _ = try await homeUseCase.fetchHome(for: 1)
            XCTFail("this test case should fail")
        } catch {
            XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
        }
    }
}

// MARK: - MockRequestAction

private class MockRequestAction: RequestAction {
    var mockResponse: HomeDTO?
    var mockError: Error?
    var lastEndpoint: EndPoint?

    func requestAsync<T>(for endPoint: any EndPoint, decoder _: JSONDecoder, responseValidation _: any HttpResponseValidation) async throws -> T where T: Decodable {
        lastEndpoint = endPoint
        if let error = mockError {
            throw error
        }
        guard let response = mockResponse as? T else {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        return response
    }
}
