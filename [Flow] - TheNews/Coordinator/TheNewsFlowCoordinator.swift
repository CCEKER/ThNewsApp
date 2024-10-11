//
//  TheNewsFlowCoordinator.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

protocol TheNewsFlowCoordinatorProtocol {
    func start()
}

protocol TheNewsFlowCoordinatorDelegate {
    
}

final class TheNewsFlowCoordinator: TheNewsFlowCoordinatorProtocol {
    
    private let delegate: TheNewsFlowCoordinatorDelegate
    private let window: UIWindow
    private var navigationController = UINavigationController()
    
    init(delegate: TheNewsFlowCoordinatorDelegate, window: UIWindow) {
        self.delegate = delegate
        self.window = window
    }
    
    func start() {
        let theNewsViewController = TheNewsViewController.build(coordinator: self)
        navigationController.viewControllers = [theNewsViewController]
        self.window.rootViewController = navigationController
    }
}

extension TheNewsFlowCoordinator: TheNewsInteractorCoordinatorDelegate {
   
    func didSelectNews(_ article: Article, selectedCategoryName: String) {
        let theNewsDetailViewController = TheNewsDetailViewController.build(coordinator: self, article: article, selectedCategoryName: selectedCategoryName)
        self.navigationController.pushViewController(theNewsDetailViewController, animated: true)
    }
}

extension TheNewsFlowCoordinator: TheNewsDetailInteractorCoordinatorDelegate {
    
}
