//
//  TheNewsInteractor.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

protocol TheNewsInteractorProtocol {
    func viewDidLoad()
    func didSelectCategory(at index: Int)
    func didSelectNews(at index: Int)
    func filterNews(for searchText: String)
    func fetchDefaultScreen()
    func createNavigationBar()
}

protocol TheNewsInteractorCoordinatorDelegate: AnyObject {
    func didSelectNews(_ article: Article, selectedCategoryName: String)
}

final class TheNewsInteractor: TheNewsInteractorProtocol {
    
    private let presenter: TheNewsPresenterProtocol
    weak var coordinator: TheNewsInteractorCoordinatorDelegate?
    private let theNewsService: TheNewsServiceProtocol
    private var categories: [Category] = []
    private var newsArticle: [Article] = []
    private var filteredNews: [Article] = []
    
    init(presenter: TheNewsPresenterProtocol, theNewsService: TheNewsServiceProtocol) {
        self.presenter = presenter
        self.theNewsService = theNewsService
    }
    
    func viewDidLoad() {
        
        theNewsService.getHeadlinesNews { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.newsArticle = articles
                    self.presenter.presentArticles(articles)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        let categories = [
            Category(name: "Top Headlines", isSelected: true),
            Category(name: "Business", isSelected: false),
            Category(name: "Entertainment", isSelected: false),
            Category(name: "Health", isSelected: false),
            Category(name: "Science", isSelected: false),
            Category(name: "Sports", isSelected: false),
            Category(name: "Technology", isSelected: false)
        ]
        self.categories = categories
        presenter.presentCategories(self.categories)
    }
    
    func didSelectCategory(at index: Int) {
        self.categories.indices.forEach { categories[$0].isSelected = ($0 == index) }
        presenter.presentCategories(categories)
        
        if let category = categories.first(where: { $0.isSelected }) {
            if category.name == "Top Headlines" {
                fetchHeadlines()
            } else {
                fetchSources(forCategory: category.name.lowercased())
            }
        }
    }
    
    private func fetchSources(forCategory category: String) {
        theNewsService.getSourcesNews(category: category) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let source):
                    self.newsArticle = source
                    self.presenter.presentArticles(source)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func fetchHeadlines() {
        theNewsService.getHeadlinesNews { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let articles):
                        self.newsArticle = articles
                        self.presenter.presentArticles(articles)
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func didSelectNews(at index: Int) {
        let selectedNews = newsArticle[index]
        let selectedCategory = getSelectedCategoryName()
        coordinator?.didSelectNews(selectedNews, selectedCategoryName: selectedCategory)
    }
    
    func filterNews(for searchText: String) {
        if searchText.isEmpty {
            filteredNews = newsArticle
        } else {
            filteredNews = newsArticle.filter { news in
                return news.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        presenter.presentArticles(filteredNews)
    }
    
    func fetchDefaultScreen() {
        presenter.presentArticles(self.newsArticle)
    }
    
    func createNavigationBar() {
        presenter.presentNavigationBar()
    }
    
    private func getSelectedCategoryName() -> String {
        categories.first(where: { $0.isSelected })?.name ?? "Kategori bulunamadı."
    }
}
