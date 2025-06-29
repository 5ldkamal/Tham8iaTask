//
//  Int+DurationFormat.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

/// Extension to the `Int` type to provide duration formatting utilities.
extension Int {
    /// Converts the integer value, interpreted as a number of seconds, into a human-readable duration string.
    ///
    /// The output format adapts based on the value:
    /// - If the value includes hours, it returns a string with hours, minutes, and optionally seconds (e.g., "2 hr 15 min 10 sec").
    /// - If the value includes only minutes and seconds, it returns a string with those units (e.g., "5 min 30 sec").
    /// - If the value is less than a minute, it returns only seconds (e.g., "45 sec").
    ///
    /// - Returns: A formatted string representing the duration.
    func formatDuration() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60

        if hours > 0 {
            if seconds > 0 {
                return "\(hours) hr \(minutes) min \(seconds) sec"
            } else {
                return "\(hours) hr \(minutes) min"
            }
        } else if minutes > 0 {
            if seconds > 0 {
                return "\(minutes) min \(seconds) sec"
            } else {
                return "\(minutes) min"
            }
        } else {
            return "\(seconds) sec"
        }
    }
}
