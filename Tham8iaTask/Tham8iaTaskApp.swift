//
//  Tham8iaTaskApp.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

@main
struct Tham8iaTaskApp: App {
    var body: some Scene {
        WindowGroup {
            if Testing.isActive {
                Text("Unit Testing is running - Skipping Main App ...")
            } else {
                HomeScreen()
            }
        }
    }
}
