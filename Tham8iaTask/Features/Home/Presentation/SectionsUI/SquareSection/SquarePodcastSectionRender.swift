//
//  SquarePodcastSectionRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation
import SwiftUI

// MARK: - SquarePodcastSectionRender

struct SquarePodcastSectionRender: AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView {
        ///
        let contents: [PodcastContent] = section.items.compactMap {
            $0 as? PodcastContent
        }
        return AnyView(SquarePodcastSectionView(contents: contents))
    }
}

// MARK: - List

private struct SquarePodcastSectionView: View {
    let contents: [PodcastContent]

    private let size: CGSize = .init(width: 150, height: 150)
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(contents) { content in
                    SquarePodcastItemView(content: content,
                                          imageSize: size)
                        .frame(width: size.width)
                }
            }
        }
    }
}

// MARK: - Card

struct SquarePodcastItemView: View {
    var content: PodcastContent
    var imageSize: CGSize

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            AsyncImageView(
                url: content.imageURL,
                size: .init(
                    width: imageSize.width,
                    height: imageSize.height
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))

            // Title
            Text(content.name)
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(1)
                .foregroundColor(Color.primaryFont)

            HStack {
                PlayingView(duration: content.duration.formatDuration())
                    .frame(height: 20)
                Spacer()
            }
        }
        .onTapGesture {
            content.onPlayerHandler?()
        }
    }
}
