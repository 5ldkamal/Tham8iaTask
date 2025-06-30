//
//  BigSquareEpisodeSectionRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 30/06/2025.
//

import Foundation
import SwiftUI

// MARK: - BigSquareAudioBookSectionRender

struct BigSquareEpisodeSectionRender: AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView {
        ///
        let contents: [EpisodeContent] = section.items.compactMap {
            $0 as? EpisodeContent
        }

        return AnyView(BigSquareEpisodeSectionView(contents: contents))
    }
}

// MARK: - List

private struct BigSquareEpisodeSectionView: View {
    let contents: [EpisodeContent]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(contents) { content in
                    BigSquareEpisodeItemView(content: content, size: .init(width: 300, height: 300))
                }
            }
        }
    }
}

// MARK: - Card

private struct BigSquareEpisodeItemView: View {
    let content: EpisodeContent
    let size: CGSize

    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let frameScale: CGFloat = 0.75
        static let heightOffset: CGFloat = 50
        static let padding: CGFloat = 24
        static let bottomPadding: CGFloat = 32
    }

    var body: some View {
        ZStack {
            AsyncImageView(
                url: content.imageURL,
                size: .init(
                    width: size.width * Constants.frameScale,
                    height: size.width * Constants.frameScale - Constants.heightOffset
                )
            )

            HStack {
                VStack {
                    Spacer()
                    Text(content.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primaryFont)
                    Text(content.title)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(Color.primaryFont)

                }.padding(.horizontal, Constants.padding)
                    .padding(.bottom, Constants.bottomPadding)
                Spacer()
            }
        }
        .frame(
            width: size.width * Constants.frameScale,
            height: size.width * Constants.frameScale - Constants.heightOffset
        )
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .onTapGesture {
            content.onTappedHandler?()
        }
    }
}
