//
//  BigSquareAudioBookSectionRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation
import SwiftUI

// MARK: - BigSquareAudioBookSectionRender

struct BigSquareAudioBookSectionRender: AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView {
        ///
        let contents: [AudioBookContent] = section.items.compactMap {
            $0 as? AudioBookContent
        }

        return AnyView(BigSquareAudioBookSectionView(contents: contents))
    }
}

// MARK: - List

private struct BigSquareAudioBookSectionView: View {
    let contents: [AudioBookContent]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(contents) { content in
                    BigSquareAudioBookItemView(content: content, size: .init(width: 300, height: 300))
                }
            }
        }
    }
}

// MARK: - Card

private struct BigSquareAudioBookItemView: View {
    let content: AudioBookContent
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
                        .foregroundColor(.white)
                        .padding(.horizontal, Constants.padding)
                        .padding(.bottom, Constants.bottomPadding)
                }
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
