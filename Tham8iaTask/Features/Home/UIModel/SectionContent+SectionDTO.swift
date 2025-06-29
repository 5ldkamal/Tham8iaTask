//
//  SectionContent+SectionDTO.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

extension Section {
    func mapToPresentationModel() -> SectionContent {
        let header = SectionHeaderContent(title: name ?? "")
        let layoutType = SectionLayoutType(rawValue: type) ?? .square
        let itemType = SectionContentItemType(rawValue: contentType) ?? .podcast

        let items: [(any SectionItemContent)?] = (content ?? []).map { item in
            switch itemType {
            case .podcast:
                return self.createPodcastContent(from: item)
            case .episode:
                return self.createEpisodeContent(from: item)
            case .audioBook:
                return self.createAudioBookContent(from: item)
            case .audioArticle:
                return self.createAudioArticleContent(from: item)
            case .unknown:
                return nil
            }
        }

        return SectionContent(
            sectionHeaderContent: header,
            sectionLayoutType: layoutType,
            sectionContentItemType: itemType,
            items: items.compactMap { $0 }
        )
    }

    private func createPodcastContent(from content: Content) -> PodcastContent {
        PodcastContent(
            id: UUID().uuidString,
            name: content.name ?? "Unknown Podcast",
            description: content.description ?? "",
            imageURL: URL(string: content.avatarURL),
            episodeCount: content.episodeCount ?? 0,
            duration: content.duration ?? 0,
            language: content.language,
            priority: content.priority,
            popularity: content.popularityScore ?? 0,
            score: content.score ?? 0.0
        )
    }

    private func createEpisodeContent(from content: Content) -> EpisodeContent {
        EpisodeContent(
            id: UUID().uuidString,
            title: content.name ?? "Unknown Episode",
            podcastName: content.podcastName ?? "Unknown Podcast",
            authorName: content.authorName ?? "Unknown Author",
            description: content.description ?? "",
            duration: content.duration ?? 0,
            releaseDate: content.releaseDate ?? "",
            imageURL: URL(string: content.avatarURL),
            audioURL: URL(string: content.audioURL),
            popularityScore: content.popularityScore ?? 0,
            priority: content.priority ?? 0,
            score: content.score ?? 0.0
        )
    }

    private func createAudioBookContent(from content: Content) -> AudioBookContent {
        AudioBookContent(
            id: UUID().uuidString,
            title: content.name ?? "Unknown Audiobook",
            authorName: content.authorName ?? "Unknown Author",
            description: content.description ?? "",
            imageURL: URL(string: content.avatarURL),
            duration: content.duration ?? 0,
            language: content.language ?? "en",
            releaseDate: content.releaseDate ?? "",
            score: content.score ?? 0.0
        )
    }

    private func createAudioArticleContent(from content: Content) -> AudioArticleContent {
        AudioArticleContent(
            id: UUID().uuidString,
            title: content.name ?? "Unknown Article",
            author: content.authorName ?? "Unknown Author",
            description: content.description ?? "",
            imageURL: URL(string: content.avatarURL),
            duration: content.duration ?? 0,
            releaseDate: content.releaseDate ?? "",
            popularityBadge: nil, onTappedHandler: nil
        )
    }
}
