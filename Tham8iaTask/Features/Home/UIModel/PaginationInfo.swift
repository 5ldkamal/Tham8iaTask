//
//  PaginationInfo.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 30/06/2025.
//

// MARK: - Supporting Types

struct PaginationInfo {
    private(set) var currentPage = 0
    private(set) var totalPages = 0
    private let pageSize = 10

    var nextPage: Int { currentPage + 1 }
    var canLoadMore: Bool { currentPage < totalPages }
    var hasReachedEnd: Bool { currentPage >= totalPages }

    mutating func reset() {
        currentPage = 0
        totalPages = 0
    }

    mutating func update(currentPage: Int, totalPages: Int) {
        self.currentPage = currentPage
        self.totalPages = totalPages
    }
}
