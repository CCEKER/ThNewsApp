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
            publishedAt: dateFormat(from: article.publishedAt ?? Date()),
            content: article.content ?? "",
            categoryName: selectedCategoryName,
            title: article.title ?? "",
            followButtonTitle: "Follow"
        )
        viewController?.displayTheNewsDetailViewModel(viewModel)
    }
    
    private func dateFormat(from date: Date) -> String {
        let calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        let startDate = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: startDate, to: now)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "'Today,' h:mm a"
            return dateFormatter.string(from: date)
        } else if let dayCount = components.day, dayCount > 0 {
            dateFormatter.dateFormat = "h:mm a "
            let timeString = dateFormatter.string(from: date)
            return "\(dayCount) day\(dayCount == 1 ? "" : "s") ago, \(timeString)"
        } else {
            dateFormatter.dateFormat = "MMM dd, yyyy, h:mm a"
            return dateFormatter.string(from: date)
        }
    }
}
