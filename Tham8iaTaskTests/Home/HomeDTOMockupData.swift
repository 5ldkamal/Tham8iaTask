//
//  HomeDTOMockupData.swift
//  Tham8iaTaskTests
//
//  Created by Khaled Kamal on 30/06/2025.
//

import Foundation
@testable import Tham8iaTask

struct HomeDTOMockupData {
    static let shared = HomeDTOMockupData()

    func getHomeDTO() -> HomeDTO {
        HomeDTO(sections: getSections(), pagination: .init(nextPage: "", totalPages: 10))
    }

    private func getSections() -> [Section] {
        [
            Section(
                name: "Popular Podcasts",
                type: "podcast",
                contentType: "audio",
                content: [
                    Content(
                        podcastID: "pod001",
                        name: "Swift Talk",
                        description: "Learn Swift and iOS development with real examples.",
                        avatarURL: "https://example.com/swifttalk.png",
                        episodeCount: 50,
                        duration: 1200,
                        language: "en",
                        priority: 1,
                        popularityScore: 1000,
                        score: 4.8,
                        podcastPopularityScore: 95,
                        podcastPriority: 2,
                        episodeID: nil,
                        seasonNumber: nil,
                        episodeType: nil,
                        podcastName: "Swift Talk",
                        authorName: "Jane Doe",
                        number: nil,
                        separatedAudioURL: nil,
                        audioURL: "https://example.com/audio.mp3",
                        releaseDate: "2025-06-25T10:00:00Z",
                        chapters: nil,
                        paidIsEarlyAccess: false,
                        paidIsNowEarlyAccess: false,
                        paidIsExclusive: false,
                        paidTranscriptURL: nil,
                        freeTranscriptURL: nil,
                        paidIsExclusivePartially: false,
                        paidExclusiveStartTime: nil,
                        paidEarlyAccessDate: nil,
                        paidEarlyAccessAudioURL: nil,
                        paidExclusivityType: nil,
                        audiobookID: nil,
                        articleID: nil
                    ),
                ]
            ),
        ]
    }
}
