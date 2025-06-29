//
//  SearchDTO.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

// MARK: - SearchDTO

struct SearchDTO: Codable {
    let sections: [SearchSection]?
}

// MARK: - Section

struct SearchSection: Codable {
    let name, type, contentType, order: String?
    let content: [SearchContent]?

    enum CodingKeys: String, CodingKey {
        case name, type
        case contentType = "content_type"
        case order, content
    }
}

// MARK: - Content

struct SearchContent: Codable {
    let podcastID, name, description: String?
    let avatarURL: String?
    let episodeCount, duration, language, priority: String?
    let popularityScore, score: String?

    enum CodingKeys: String, CodingKey {
        case podcastID = "podcast_id"
        case name, description
        case avatarURL = "avatar_url"
        case episodeCount = "episode_count"
        case duration, language, priority, popularityScore, score
    }
}
