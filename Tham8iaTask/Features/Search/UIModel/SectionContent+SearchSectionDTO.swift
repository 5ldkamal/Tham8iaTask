//
//  SectionContent+SearchSectionDTO.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

extension SearchSection {
    func mapToPresentationModel() -> SectionContent {
        let header = SectionHeaderContent(title: name ?? "")
        let layoutType = SectionLayoutType(rawValue: type) ?? .square
        let itemType = SectionContentItemType(rawValue: contentType) ?? .podcast

        let items: [(any SectionItemContent)?] = (content ?? []).map { item in
            self.createPodcastContent(from: item)
        }

        return SectionContent(
            sectionHeaderContent: header,
            sectionLayoutType: layoutType,
            sectionContentItemType: itemType,
            items: items.compactMap { $0 }
        )
    }

    private func createPodcastContent(from content: SearchContent) -> PodcastContent {
        PodcastContent(
            id: UUID().uuidString,
            name: content.name ?? "Unknown Podcast",
            description: content.description ?? "",
            imageURL: URL(string: content.avatarURL),
            episodeCount: Int.random(in: 0 ..< 30), /* should handled from api*/
            duration: Int.random(in: 100 ..< 5000), /* should handled from api*/
            language: content.language,
            priority: 0,
            popularity: 0, /* should handled from api*/
            score: Double.random(in: 0 ..< 9) /* should handled from api*/
        )
    }
}
