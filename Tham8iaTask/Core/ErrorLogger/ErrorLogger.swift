//
//  ErrorLogger.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

/// A protocol that defines the interface for logging errors.
///
/// Conforming types should implement a method to log errors for debugging or monitoring purposes.
protocol ErrorLoggerProtocol {
    /// Logs the provided error.
    /// - Parameter error: The error to be logged.
    func log(error: Error)
}

/// A singleton class responsible for logging errors throughout the application.
///
/// This class provides a shared instance and implements the `ErrorLoggerProtocol`.
/// It currently logs errors to the console, but can be extended to use external logging SDKs.
class ErrorLogger: ErrorLoggerProtocol {
    /// The shared singleton instance of `ErrorLogger`.
    static let shared = ErrorLogger()

    /// Logs the provided error using the current logging mechanism.
    ///
    /// - Parameter error: The error to be logged. This can be any type conforming to the `Error` protocol.
    ///
    /// You can replace the print statement with a third-party logging SDK if needed.
    func log(error: any Error) {
        /// U can use Logger SDK
        print(error.localizedDescription)
    }
}
