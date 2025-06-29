//
//  URL+OptionalString.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

/// Extension to the `URL` type to provide convenience initialization from an optional string.
extension URL {
    /// Creates a new URL instance from an optional string.
    ///
    /// If the provided string is `nil`, the initializer returns `nil`. If the string is non-nil, it attempts to initialize a URL from it.
    ///
    /// - Parameter string: An optional string to use for URL initialization.
    /// - Returns: A URL if the string is non-nil and a valid URL, otherwise `nil`.
    init?(string: String?) {
        guard let string = string else {
            return nil
        }
        self.init(string: string)
    }
}
