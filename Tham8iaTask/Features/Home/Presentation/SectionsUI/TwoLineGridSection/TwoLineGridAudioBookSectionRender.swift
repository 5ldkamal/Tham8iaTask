//
//  TwoLineGridAudioBookSectionRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation
import SwiftUI

// MARK: - TwoLineGridAudioBookSectionRender

struct TwoLineGridAudioBookSectionRender: AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView {
        let contents: [AudioBookContent] = section.items.compactMap {
            $0 as? AudioBookContent
        }
        return AnyView(TwoLineGridAudioBookSectionView(contents: contents))
    }
}

// MARK: - List

struct TwoLineGridAudioBookSectionView: View {
    let contents: [AudioBookContent]
    private let rows: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 15) {
                ForEach(contents) { content in
                    TwoLineGridAudioBookItemView(content: content)
                        .frame(width: screenWidth * 0.8)
                        .frame(height: 130)
                }
            }
        }
    }
}

// MARK: - Card

struct TwoLineGridAudioBookItemView: View {
    let content: AudioBookContent

    var body: some View {
        HStack(spacing: 15) {
            AsyncImageView(url: content.imageURL, size: .init(width: 100, height: 130))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            TwoLineGridAudioBookItemInfo(content: content)
        }
        .onTapGesture {
            content.onTappedHandler?()
        }
    }
}

struct TwoLineGridAudioBookItemInfo: View {
    var content: AudioBookContent

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(content.authorName)
                .font(.caption)
                .foregroundColor(.gray)

            Text(content.title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primaryFont)
                .multilineTextAlignment(.trailing)

            Text(content.description)
                .font(.footnote)
                .foregroundColor(.primaryFont)
                .lineLimit(2)

            HStack {
                PlayingView(duration: content.duration.formatDuration())

                Spacer()

                Button(action: {
                    content.onTappedHandler?()
                }) {
                    Image(systemName: "ellipsis").foregroundStyle(Color.primaryFont)
                }
                .padding(.leading, 20)

                Button(action: {
                    content.onManuHandler?()
                }) {
                    Image(systemName: "books.vertical.fill").foregroundStyle(Color.primaryFont)
                }
            }
        }
    }
}
