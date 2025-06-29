//
//  String+DateFormat.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

/// Extension to the `String` type to provide date formatting utilities.
extension String {
    /// Converts an ISO8601 date string into a human-readable, relative date string.
    ///
    /// This method attempts to parse the string as an ISO8601 date. If successful, it returns a relative date string (e.g., "2 hr ago", "yesterday")
    /// using `RelativeDateTimeFormatter`. If parsing fails, it returns "Unknown Date".
    ///
    /// - Returns: A formatted string representing the relative date, or "Unknown Date" if parsing fails.
    func formatDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: self) else {
            return "Unknown Date"
        }

        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .short // Options: .full, .short, .abbreviated

        return relativeFormatter.localizedString(for: date, relativeTo: Date())
    }
}
