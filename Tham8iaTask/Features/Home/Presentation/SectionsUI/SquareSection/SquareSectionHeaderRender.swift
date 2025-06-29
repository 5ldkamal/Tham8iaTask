//
//  SquareSectionHeaderRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct SquareSectionHeaderRender: AnyHeaderRenderer {
    func render(header section: SectionContent) -> AnyView? {
        guard section.sectionLayoutType == .square else {
            return nil
        }
        return AnyView(SquareSectionHeaderView(headerModel: section.sectionHeaderContent))
    }
}

private struct SquareSectionHeaderView: View {
    var headerModel: SectionHeaderContent
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Text(headerModel.title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.yellow)

                Image(systemName: "seal.fill")
                    .font(.caption2)
                    .foregroundColor(.yellow)
            }

            Spacer()

            Button(action: {
                headerModel.onTapHandler?()
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(Color.primaryFont)
                    .fontWeight(.medium)
            }
        }
    }
}
