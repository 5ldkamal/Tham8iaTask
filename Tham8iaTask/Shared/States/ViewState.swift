//
//  ViewState.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

enum ViewState<T>: Equatable where T: Equatable {
    case idle
    case loading
    case loaded(T)
    case error(String)
    case empty(EmptyStateModel)

    static func == (lhs: ViewState<T>, rhs: ViewState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case let (.loaded(lhsData), .loaded(rhsData)):
            return lhsData == rhsData
        case let (.error(lhsError), .error(rhsError)):
            return lhsError == rhsError
        case let (.empty(lhsState), .empty(rhsState)):
            return lhsState == rhsState
        default:
            return false
        }
    }
}
