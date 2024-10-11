//
//  TheNewsDetailInteractor.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 8.10.2024.
//

import Foundation

protocol TheNewsDetailInteractorProtocol {
    func viewDidLoad()
}

protocol TheNewsDetailInteractorCoordinatorDelegate: AnyObject {
    
}

final class TheNewsDetailInteractor: TheNewsDetailInteractorProtocol {
    
    private let presenter: TheNewsDetailPresenterProtocol
    weak var coordinator: TheNewsDetailInteractorCoordinatorDelegate?
    private var article: Article
    private var selectedCategoryName: String
    
    init(presenter: TheNewsDetailPresenterProtocol, article: Article, selectedCategoryName: String) {
        self.presenter = presenter
        self.article = article
        self.selectedCategoryName = selectedCategoryName
    }
    
    func viewDidLoad() {
        presenter.presentTheNewsDetail(self.article, selectedCategoryName: self.selectedCategoryName)
    }
}
