//
//  TheNewsViewController+Build.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

extension TheNewsViewController {
    static func build(coordinator: TheNewsInteractorCoordinatorDelegate) -> UIViewController {
        let presenter = TheNewsPresenter()
        let interactor = TheNewsInteractor(presenter: presenter, theNewsService: TheNewsService())
        interactor.coordinator = coordinator
        let viewController = TheNewsViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
