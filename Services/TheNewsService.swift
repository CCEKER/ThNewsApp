//
//  TheNewsService.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit
import Alamofire

protocol TheNewsServiceProtocol {
    func getHeadlinesNews(completion: @escaping (Result<[Article], Error>) -> Void)
    func getSourcesNews(category: String, completion: @escaping (Result<[Article], Error>) -> Void)
}

final class TheNewsService: TheNewsServiceProtocol {
    
    func getHeadlinesNews(completion: @escaping (Result<[Article], any Error>) -> Void) {
     
        let apiKey = ApiKey.apiKey
        let url = NetworkLayerConstant.topHeadlinesURL + apiKey
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseDecodable(of: Headline.self) { response in
        
            switch response.result {
            case .success(let headline):
                completion(.success(headline.articles))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSourcesNews(category: String, completion: @escaping (Result<[Article], any Error>) -> Void) {
        
        let url = NetworkLayerConstant.categoryURL(for: category)
        
        AF.request(url, method: .get).responseDecodable(of: Headline.self) { response in
            switch response.result {
            case .success(let sourceResponse):
                completion(.success(sourceResponse.articles))
            case .failure(let error):
                print(error)
            }
        }
    }
}
