//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Khaled Kamal on 08/09/2023.
//

import Foundation

struct InvalidURLError: LocalizedError {
    var url: URL?

    var errorDescription: String? {
        "Invalid end url \(url?.absoluteString)"
    }
}
