//
//  SectionContent.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

// MARK: - Section Content

struct SectionContent: Identifiable, Equatable {
    /*
     We can replace this id be id coming from BE
     */
    var id = UUID()
    var sectionHeaderContent: SectionHeaderContent
    var sectionLayoutType: SectionLayoutType
    var sectionContentItemType: SectionContentItemType
    var items: [any SectionItemContent]

    static func == (lhs: SectionContent, rhs: SectionContent) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Section Header info

struct SectionHeaderContent {
    var title: String
    var onTapHandler: (() -> Void)?
}

// MARK: - Section Item Layout

enum SectionLayoutType: String {
    case square
    case bigSquare = "big square"
    case twoLinesGrid = "2_lines_grid"
    case queue
    case unknown

    init?(rawValue: String?) {
        guard let rawValue = rawValue else {
            return nil
        }

        let normalized = rawValue
            .replacingOccurrences(of: "_", with: " ")
            .lowercased()

        switch normalized {
        case "square":
            self = .square
        case "big square":
            self = .bigSquare
        case "2 lines grid":
            self = .twoLinesGrid
        case "queue":
            self = .queue
        default:
            self = .unknown
        }
    }
}

// MARK: - Section Item Type

enum SectionContentItemType: String {
    case podcast
    case episode
    case audioBook = "audio_book"
    case audioArticle = "audio_article"
    case unknown

    init?(rawValue: String?) {
        guard let rawValue = rawValue else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}

// MARK: - Section Item Content

protocol SectionItemContent: Identifiable {}

struct PodcastContent: SectionItemContent {
    let id: String
    let name: String
    let description: String
    let imageURL: URL?
    let episodeCount: Int
    let duration: Int
    let language: String?
    let priority: Int?
    let popularity: Int
    let score: Double
    var onTappedHandler: (() -> Void)?
    var onPlayerHandler: (() -> Void)?
}

struct EpisodeContent: SectionItemContent {
    let id: String
    let title: String
    let podcastName: String
    let authorName: String
    let description: String
    let duration: Int
    let releaseDate: String
    let imageURL: URL?
    let audioURL: URL?
    let popularityScore: Int
    let priority: Int
    let score: Double
    var onTappedHandler: (() -> Void)?
    var onManuHandler: (() -> Void)?
    var onPlayerHandler: (() -> Void)?
}

struct AudioBookContent: SectionItemContent {
    let id: String
    let title: String
    let authorName: String
    let description: String
    let imageURL: URL?
    let duration: Int
    let language: String
    let releaseDate: String
    let score: Double
    var onTappedHandler: (() -> Void)?
    var onManuHandler: (() -> Void)?
}

struct AudioArticleContent: SectionItemContent {
    let id: String
    let title: String
    let author: String
    let description: String
    let imageURL: URL?
    let duration: Int
    let releaseDate: String
    let popularityBadge: String?
    var onTappedHandler: (() -> Void)?
    var onPlayerHandler: (() -> Void)?
}
