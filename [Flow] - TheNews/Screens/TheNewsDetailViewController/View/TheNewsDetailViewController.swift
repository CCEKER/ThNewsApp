//
//  TheNewsDetailViewController.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 8.10.2024.
//

import UIKit

protocol TheNewsDetailViewControllerProtocol: AnyObject {
    func displayTheNewsDetailViewModel(_ viewModel: TheNewsDetailViewModel)
}

class TheNewsDetailViewController: UIViewController {
    
    private let customView = TheNewsDetailView()
    private let interactor: TheNewsDetailInteractorProtocol
    
    init(interactor: TheNewsDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.viewDidLoad()
    }
}

extension TheNewsDetailViewController: TheNewsDetailViewControllerProtocol {
    
    func displayTheNewsDetailViewModel(_ viewModel: TheNewsDetailViewModel) {
        customView.reloadWith(viewModel)
    }
}
