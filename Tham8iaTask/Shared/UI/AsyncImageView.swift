//
//  AsyncImageView.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

/// A SwiftUI view that asynchronously loads and displays an image from a URL, with support for a customizable placeholder and size.
///
/// `AsyncImageView` wraps SwiftUI's `AsyncImage` and provides additional configuration for image size and placeholder content.
/// The image is displayed with rounded corners. If the image fails to load or is empty, the placeholder is shown instead.
///
/// - Parameters:
///   - Placeholder: A SwiftUI `View` type used as a placeholder while the image loads or if loading fails.
struct AsyncImageView<Placeholder: View>: View {
    /// The URL of the image to load asynchronously.
    let url: URL?
    /// The size to display the image or placeholder.
    let size: CGSize
    /// The view to display as a placeholder while loading or on failure.
    let placeholder: Placeholder

    /// Creates an `AsyncImageView` with the specified URL, size, and placeholder.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to load.
    ///   - size: The size for the image or placeholder.
    ///   - placeholder: A view builder that provides the placeholder view. Defaults to a gray color.
    init(
        url: URL?,
        size: CGSize,
        @ViewBuilder placeholder: () -> Placeholder = { Color.gray }
    ) {
        self.url = url
        self.size = size
        self.placeholder = placeholder()
    }

    /// The content and behavior of the view.
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            case .failure(_), .empty:
                placeholder
                    .frame(width: size.width, height: size.height)
                    .clipped()
            @unknown default:
                placeholder
                    .frame(width: size.width, height: size.height)
                    .clipped()
            }
        }
    }
}
