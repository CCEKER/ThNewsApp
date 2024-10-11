//
//  NetworkLayerConstant.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import Alamofire

struct NetworkLayerConstant {
    static var topHeadlinesURL: String {
        return "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    }
    static func categoryURL(for category: String) -> String {
        return "https://newsapi.org/v2/top-headlines?apiKey=\(ApiKey.apiKey)&country=us&category=\(category)"
    }
}

enum ApiKey {
    static let apiKey: String = "5383ca0b906b41bbb70852258a0ac9da"
}
