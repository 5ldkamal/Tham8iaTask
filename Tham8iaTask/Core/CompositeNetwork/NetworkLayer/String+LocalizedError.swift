//
//  String+LocalizedError.swift
//  SwiftUITutorial
//
//  Created by Khaled Kamal on 26/06/2025.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}
