//
//  EmptyStateView.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct EmptyStateModel {
    let title: String
    let message: String
    let imageName: String
}

extension EmptyStateModel {
    static func `default`() -> EmptyStateModel {
        EmptyStateModel(title: "No Data",
                        message: "There’s nothing to display right now.",
                        imageName: "tray")
    }

    static func search() -> EmptyStateModel {
        EmptyStateModel(title: "No Results",
                        message: "Try adjusting your search or filters.",
                        imageName: "magnifyingglass")
    }

    static func network() -> EmptyStateModel {
        EmptyStateModel(
            title: "No Connection",
            message: "Check your internet and try again.",
            imageName: "wifi.slash"
        )
    }
}

struct EmptyStateView: View {
    var emptyModel: EmptyStateModel

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: emptyModel.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Text(emptyModel.title)
                .font(.headline)
                .foregroundStyle(.primaryFont)
            Text(emptyModel.message)
                .font(.subheadline)
                .foregroundColor(.primaryFont)
        }
        .padding()
    }
}
