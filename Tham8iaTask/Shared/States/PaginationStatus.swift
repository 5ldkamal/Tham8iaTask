//
//  PaginationStatus.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 30/06/2025.
//

import Foundation

enum PaginationStatus: Equatable {
    case idle
    case loading
    case error(String)
    case endReached
}
