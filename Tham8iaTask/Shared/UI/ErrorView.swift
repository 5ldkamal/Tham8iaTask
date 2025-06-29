//
//  ErrorView.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    var retryHandler: (() -> Void)?

    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundColor(.red)
            Button("Retry") {
                retryHandler?()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
