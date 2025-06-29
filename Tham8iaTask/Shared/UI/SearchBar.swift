//
//  SearchBar.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    var placeholder: String = "Search..."
    var onSearchButtonClicked: (() -> Void)?
    var onCancelButtonClicked: (() -> Void)?

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .padding(.leading, 8)

                TextField(placeholder, text: $text,
                          onEditingChanged: { editing in
                              isEditing = editing
                          }, onCommit: {
                              onSearchButtonClicked?()
                          })
                          .textFieldStyle(PlainTextFieldStyle())
                          .padding(.vertical, 8)

                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .padding(.trailing, 8)
                    }
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(10)

            if isEditing {
                Button("Cancel") {
                    isEditing = false
                    text = ""
                    onCancelButtonClicked?()

                    // Dismiss keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .foregroundColor(.blue)
                .padding(.leading, 8)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
        .padding(.horizontal)
    }
}
