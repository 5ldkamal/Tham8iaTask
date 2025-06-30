//
//  SquareAudioArticleRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

// MARK: - SquareAudioArticleRender

struct SquareAudioArticleRender: AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView {
        ///
        let contents: [AudioArticleContent] = section.items.compactMap {
            $0 as? AudioArticleContent
        }

        return AnyView(SquareAudioArticleSectionView(contents: contents))
    }
}

// MARK: - List

private struct SquareAudioArticleSectionView: View {
    var contents: [AudioArticleContent]
    private let size: CGSize = .init(width: 150, height: 150)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(contents) { content in
                    SquareAudioArticleItemView(content: content,
                                               imageSize: size)
                        .frame(width: size.width)
                }
            }
        }
    }
}

// MARK: - Card

private struct SquareAudioArticleItemView: View {
    var content: AudioArticleContent
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
            Text(content.title)
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(1)
                .foregroundColor(Color.primaryFont)

            HStack {
                PlayingView(duration: content.duration.formatDuration())
                    .frame(width: 80, height: 20)
                    .layoutPriority(1)
                Text(content.releaseDate.formatDate())
                    .font(.caption2)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .layoutPriority(0)
            }
        }
        .onTapGesture {
            content.onPlayerHandler?()
        }
    }
}
