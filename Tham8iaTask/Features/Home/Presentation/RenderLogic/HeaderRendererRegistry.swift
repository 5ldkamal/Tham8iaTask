//
//  HeaderRendererRegistry.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

final class HeaderRendererRegistry {
    private var renderers: [SectionLayoutType: AnyHeaderRenderer] = [:]

    func register(sectionType: SectionLayoutType, renderer: AnyHeaderRenderer) {
        renderers[sectionType] = renderer
    }

    func view(section: SectionContent) -> AnyView? {
        renderers[section.sectionLayoutType]?.render(header: section)
    }
}

extension HeaderRendererRegistry {
    static func `default`() -> HeaderRendererRegistry {
        let registry = HeaderRendererRegistry()

        registry.register(sectionType: .bigSquare, renderer: SharedSectionHeaderRender())
        registry.register(sectionType: .queue, renderer: SharedSectionHeaderRender())
        registry.register(sectionType: .twoLinesGrid, renderer: SharedSectionHeaderRender())

        registry.register(sectionType: .square, renderer: SquareSectionHeaderRender())

        return registry
    }
}
