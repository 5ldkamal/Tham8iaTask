//
//  SectionRendererRegistry.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct SectionKey: Hashable {
    let layout: SectionLayoutType
    let content: SectionContentItemType
}

class SectionRendererRegistry {
    private var renderers: [SectionKey: AnySectionItemsRenderer] = [:]

    func register(
        layout: SectionLayoutType,
        content: SectionContentItemType,
        renderer: AnySectionItemsRenderer
    ) {
        renderers[SectionKey(layout: layout, content: content)] = renderer
    }

    func view(
        for section: SectionContent
    ) -> AnyView {
        let key = SectionKey(layout: section.sectionLayoutType, content: section.sectionContentItemType)
        return renderers[key]?.render(section: section) ?? AnyView(EmptyView())
    }
}

extension SectionRendererRegistry {
    static func `default`() -> SectionRendererRegistry {
        let registry = SectionRendererRegistry()

        registry.register(layout: .bigSquare, content: .audioBook, renderer: BigSquareAudioBookSectionRender())

        registry.register(layout: .square, content: .audioArticle, renderer: SquareAudioArticleRender())
        registry.register(layout: .square, content: .podcast, renderer: SquarePodcastSectionRender())

        registry.register(layout: .twoLinesGrid, content: .audioBook, renderer: TwoLineGridAudioBookSectionRender())
        registry.register(layout: .twoLinesGrid, content: .episode, renderer: TwoLineGridEpisodeSectionRender())

        registry.register(layout: .queue, content: .podcast, renderer: QueuePodcastSectionRender())

        return registry
    }
}
