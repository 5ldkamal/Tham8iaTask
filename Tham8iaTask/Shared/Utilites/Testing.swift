//
//  Testing.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 30/06/2025.
//

import Foundation

enum Testing {
    static var isActive: Bool {
        NSClassFromString("XCTest") != nil
    }
}
