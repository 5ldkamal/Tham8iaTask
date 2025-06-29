//
//  ViewState.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

enum ViewState<Data> {
    case idle
    case loading
    case loaded(Data)
    case empty(EmptyStateModel)
    case error(String)
}
