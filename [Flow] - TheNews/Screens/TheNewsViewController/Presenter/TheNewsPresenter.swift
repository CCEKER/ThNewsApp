//
//  TheNewsPresenter.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

protocol TheNewsPresenterProtocol {
    func presentCategories(_ categories: [Category])
    func presentArticles(_ article: [Article])
    func presentNavigationBar()
}

final class TheNewsPresenter: TheNewsPresenterProtocol {
    
    weak var viewController: TheNewsViewControllerProtocol?
    
    func presentCategories(_ categories: [Category]) {
        let viewModel = categories.map { category in
            CategoriesViewModel(
                name: category.name,
                isSelected: category.isSelected
            )
        }
        viewController?.displayCategoriesViewModel(viewModel)
    }
    
    func presentArticles(_ article: [Article]) {
        let viewModel = article.map { article in
            TheHeadlineNewsViewModel(
                description: article.description ?? "",
                title: article.title ?? "",
                newsImage: article.urlToImage ?? "",
                date: format(from: article.publishedAt ?? Date())
            )
        }
        viewController?.displayTheHeadlineNewsViewModel(viewModel)
    }
    
    private func format(from date: Date) -> String {
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
    
    func presentNavigationBar() {
        let navigationBarViewModel = NavigationBarViewModel(
            title: "Inbox",
            backgroundColor: .systemBackground,
            leftImage: UIImage(systemName: "person.fill"),
            rightImage: UIImage(systemName: "list.bullet")
        )
        viewController?.displayNavigationBarViewModel(navigationBarViewModel)
    }
}
