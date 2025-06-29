//
//  HomeDTO.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation

// MARK: - HomeDTO

struct HomeDTO: Codable {
    let sections: [Section]?
    let pagination: Pagination?
}

// MARK: - Pagination

struct Pagination: Codable {
    let nextPage: String?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
        case totalPages = "total_pages"
    }
}

// MARK: - Section

struct Section: Codable {
    let name, type, contentType: String?
    let content: [Content]?

    enum CodingKeys: String, CodingKey {
        case name, type
        case contentType = "content_type"
        case content
    }
}

// MARK: - Content

struct Content: Codable {
    let podcastID, name, description: String?
    let avatarURL: String?
    let episodeCount, duration: Int?
    let language: String?
    let priority, popularityScore: Int?
    let score: Double?
    let podcastPopularityScore, podcastPriority: Int?
    let episodeID: String?
    let seasonNumber: String?
    let episodeType: String?
    let podcastName: String?
    let authorName: String?
    let number: String?
    let separatedAudioURL, audioURL: String?
    let releaseDate: String?
    let chapters: [String]?
    let paidIsEarlyAccess, paidIsNowEarlyAccess, paidIsExclusive: Bool?
    let paidTranscriptURL, freeTranscriptURL: String?
    let paidIsExclusivePartially: Bool?
    let paidExclusiveStartTime: Int?
    let paidEarlyAccessDate, paidEarlyAccessAudioURL, paidExclusivityType: String?
    let audiobookID: String?
    let articleID: String?

    enum CodingKeys: String, CodingKey {
        case podcastID = "podcast_id"
        case name, description
        case avatarURL = "avatar_url"
        case episodeCount = "episode_count"
        case duration, language, priority, popularityScore, score, podcastPopularityScore, podcastPriority
        case episodeID = "episode_id"
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case number
        case separatedAudioURL = "separated_audio_url"
        case audioURL = "audio_url"
        case releaseDate = "release_date"
        case chapters
        case paidIsEarlyAccess = "paid_is_early_access"
        case paidIsNowEarlyAccess = "paid_is_now_early_access"
        case paidIsExclusive = "paid_is_exclusive"
        case paidTranscriptURL = "paid_transcript_url"
        case freeTranscriptURL = "free_transcript_url"
        case paidIsExclusivePartially = "paid_is_exclusive_partially"
        case paidExclusiveStartTime = "paid_exclusive_start_time"
        case paidEarlyAccessDate = "paid_early_access_date"
        case paidEarlyAccessAudioURL = "paid_early_access_audio_url"
        case paidExclusivityType = "paid_exclusivity_type"
        case audiobookID = "audiobook_id"
        case articleID = "article_id"
    }
}
