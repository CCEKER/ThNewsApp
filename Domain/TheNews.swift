//
//  TheNews.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

struct Headline: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var content: String?
    var url: URL?
    var urlToImage: String?
    var publishedAt: Date?
    var source: Source?
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case content
        case url
        case urlToImage
        case publishedAt
        case source
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        let publishedAtString = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        if let dateString = publishedAtString {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            publishedAt = formatter.date(from: dateString)
        } else {
            publishedAt = nil
        }
        source = try container.decodeIfPresent(Source.self, forKey: .source)
    }
}

struct Source: Codable {
    var name: String?
    var id: String?
}
