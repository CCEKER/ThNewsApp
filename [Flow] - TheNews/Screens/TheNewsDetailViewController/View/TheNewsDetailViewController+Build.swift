//
//  TheNewsDetailViewController+Build.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 8.10.2024.
//

import UIKit

extension TheNewsDetailViewController {
    static func build(coordinator: TheNewsDetailInteractorCoordinatorDelegate, article: Article, selectedCategoryName: String) -> UIViewController {
        let presenter = TheNewsDetailPresenter()
        let interactor = TheNewsDetailInteractor(presenter: presenter, article: article, selectedCategoryName: selectedCategoryName)
        interactor.coordinator = coordinator
        let viewController = TheNewsDetailViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
