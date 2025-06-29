//
//  QueuePodcastSectionRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation
import SwiftUI

// MARK: - QueuePodcastSectionRender

struct QueuePodcastSectionRender: AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView {
        ///
        let contents: [PodcastContent] = section.items.compactMap {
            $0 as? PodcastContent
        }
        return AnyView(QueuePodcastSectionView(contents: contents))
    }
}

// MARK: -  List

private struct QueuePodcastSectionView: View {
    let contents: [PodcastContent]

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(contents) { content in
                    QueuePodcastItemView(
                        content: content
                    ).frame(
                        width: screenWidth * 0.8,
                        height: 150
                    )
                }
            }
        }
    }
}

// MARK: -  Card

private struct QueuePodcastItemView: View {
    let content: PodcastContent

    var body: some View {
        HStack(spacing: 8) {
            AsyncImageView(
                url: content.imageURL,
                size: .init(
                    width: 150,
                    height: 100
                )
            )
            .padding(.leading, 16)
            .padding(.vertical, 16)

            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                Text(content.name)
                    .font(.caption2)
                    .foregroundColor(Color.primaryFont)
                    .lineLimit(2)

                // Time info
                HStack(spacing: 4) {
                    Text("3 hours ago") // Update this by BE
                    Text(content.duration.formatDuration())
                        .foregroundColor(.red)
                }
                .font(.caption)
                .foregroundColor(.white)

                HStack {
                    Spacer()
                    QueuePodcastPlayerICon(onPlayerHandler: content.onTappedHandler)
                }.padding(.bottom, 8).padding(.trailing, 8)
            }
        }
        .background(Color.queueCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 0)
    }
}

private struct QueuePodcastPlayerICon: View {
    let onPlayerHandler: (() -> Void)?

    var body: some View {
        // Play button
        Button(action: {
            onPlayerHandler?()
        }) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)

                Image(systemName: "play.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .offset(x: 2)
            }
        }
    }
}
