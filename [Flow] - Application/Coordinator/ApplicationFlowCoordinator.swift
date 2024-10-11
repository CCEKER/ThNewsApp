//
//  ApplicationFlowCoordinator.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

protocol ApplicationFlowCoordinatorProtocol {
    func start()
}

final class ApplicationFlowCoordinator: ApplicationFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private var theNewsFlowCoordinator: TheNewsFlowCoordinatorProtocol?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        theNewsFlowCoordinator = TheNewsFlowCoordinator(delegate: self, window: self.window)
        theNewsFlowCoordinator?.start()
    }
}

extension ApplicationFlowCoordinator: TheNewsFlowCoordinatorDelegate {
    
}
