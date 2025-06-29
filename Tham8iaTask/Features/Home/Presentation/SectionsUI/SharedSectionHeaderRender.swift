//
//  SharedSectionHeaderRender.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct SharedSectionHeaderRender: AnyHeaderRenderer {
    func render(header section: SectionContent) -> AnyView? {
        guard section.sectionLayoutType != .square else {
            return nil
        }
        return AnyView(SharedSectionHeaderView(headerModel: section.sectionHeaderContent))
    }
}

private struct SharedSectionHeaderView: View {
    var headerModel: SectionHeaderContent

    var body: some View {
        HStack {
            Text(headerModel.title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.primaryFont)

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
