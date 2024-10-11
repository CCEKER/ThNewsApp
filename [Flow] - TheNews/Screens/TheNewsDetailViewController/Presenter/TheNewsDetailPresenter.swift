//
//  TheNewsDetailPresenter.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 8.10.2024.
//

import Foundation

protocol TheNewsDetailPresenterProtocol {
    func presentTheNewsDetail(_ article: Article, selectedCategoryName: String)
}

final class TheNewsDetailPresenter: TheNewsDetailPresenterProtocol {
    
    weak var viewController: TheNewsDetailViewControllerProtocol?
    
    func presentTheNewsDetail(_ article: Article, selectedCategoryName: String) {
        let viewModel = TheNewsDetailViewModel(
            companyName: article.source?.name ?? "",
            author: article.author ?? "",
            description: article.description ?? "",
            url: article.url,
            urlToImage: article.urlToImage ?? "",
            publishedAt: article.publishedAt ?? Date(),
            content: article.content ?? "",
            categoryName: selectedCategoryName
        )
        viewController?.displayTheNewsDetailViewModel(viewModel)
    }
}
