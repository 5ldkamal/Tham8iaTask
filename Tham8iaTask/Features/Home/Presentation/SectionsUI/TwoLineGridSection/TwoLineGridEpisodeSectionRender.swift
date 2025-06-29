//
//  TwoLineGridEpisodeSectionRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

// MARK: - TwoLineGridEpisodeSectionRender

struct TwoLineGridEpisodeSectionRender: AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView {
        let contents: [EpisodeContent] = section.items.compactMap {
            $0 as? EpisodeContent
        }
        return AnyView(TwoLineGridEpisodeSectionView(contents: contents))
    }
}

// MARK: - List

private struct TwoLineGridEpisodeSectionView: View {
    let contents: [EpisodeContent]
    private let rows: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 15) {
                ForEach(contents) { content in
                    TwoLineGridEpisodeItemView(content: content)
                        .frame(width: screenWidth * 0.8)
                        .frame(height: 100)
                }
            }
        }
    }
}

// MARK: - Card

private struct TwoLineGridEpisodeItemView: View {
    let content: EpisodeContent

    var body: some View {
        HStack(spacing: 15) {
            AsyncImageView(url: content.imageURL, size: .init(width: 100, height: 100))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            TwoLineGridEpisodeItemInfo(content: content)
        }
        .onTapGesture {
            content.onTappedHandler?()
        }
    }
}

private struct TwoLineGridEpisodeItemInfo: View {
    var content: EpisodeContent

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(content.releaseDate.formatDate())
                .font(.caption)
                .foregroundColor(.gray)

            // Main title
            Text(content.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primaryFont)

            // Bottom controls
            HStack {
                PlayingView(duration: content.duration.formatDuration())

                Spacer()

                // More options button (three dots)
                Button(action: {
                    content.onTappedHandler?()
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color.primaryFont)
                }
                .padding(.leading, 20)

                Button(action: {
                    content.onManuHandler?()
                }) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundStyle(Color.primaryFont)
                }
            }
        }
    }
}
