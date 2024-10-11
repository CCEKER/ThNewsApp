//
//  TheNewsViewController.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

protocol TheNewsViewControllerProtocol: AnyObject {
    func displayCategoriesViewModel(_ viewModel: [CategoriesViewModel])
    func displaySourceViewModel(_ viewModel: [SourceViewModel])
    func displayTheHeadlineNewsViewModel(_ viewModel: [TheHeadlineNewsViewModel])
    func displayNavigationBarViewModel(_ viewModel: NavigationBarViewModel)
}

class TheNewsViewController: UIViewController {
    
    private let customView = TheNewsView()
    private let interactor: TheNewsInteractorProtocol
    private var collectionData: [CategoriesViewModel] = []
    private var tableData: [TheHeadlineNewsViewModel] = []
    private var soruceData: [SourceViewModel] = []
    
    init(interactor: TheNewsInteractorProtocol) {
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
        
        customView.newsCaterogiesCollectionView.delegate = self
        customView.newsCaterogiesCollectionView.dataSource = self
        
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        
        customView.delegate = self
        
        interactor.createNavigationBar()
        
        interactor.viewDidLoad()
    }
}

extension TheNewsViewController: TheNewsViewControllerProtocol {
    
    func displayCategoriesViewModel(_ viewModel: [CategoriesViewModel]) {
        self.collectionData = viewModel
        self.customView.newsCaterogiesCollectionView.reloadData()
    }
    
    func displaySourceViewModel(_ viewModel: [SourceViewModel]) {
        self.soruceData = viewModel
        self.customView.tableView.reloadData()
    }
    
    func displayTheHeadlineNewsViewModel(_ viewModel: [TheHeadlineNewsViewModel]) {
        self.tableData = viewModel
        customView.tableView.reloadData()
    }
    
    func displayNavigationBarViewModel(_ viewModel: NavigationBarViewModel) {
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.backgroundColor = viewModel.backgroundColor
        
        let rightFirstButton = UIBarButtonItem(image: viewModel.leftImage, style: .plain, target: self, action: #selector(rightFirstButtonTapped))
        let rightSecondButton = UIBarButtonItem(image: viewModel.rightImage, style: .plain, target: self, action: #selector(rightSecondButtonTapped))
        navigationItem.rightBarButtonItems = [rightSecondButton, rightFirstButton]
    }
    
    @objc private func rightFirstButtonTapped() {
        
    }
    
    @objc private func rightSecondButtonTapped() {
        
    }
}

extension TheNewsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        let categoryName = self.collectionData[indexPath.row]
        cell.reloadWith(categoryName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didSelectCategory(at: indexPath.row)
    }
}

extension TheNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TheNewsTableViewCell.identifier, for: indexPath) as! TheNewsTableViewCell
        let article = tableData[indexPath.row]
        cell.reloadWith(article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.didSelectNews(at: indexPath.row)
    }
}

extension TheNewsViewController: TheNewsViewDelegate {
    
    func didTapSearch(text: String) {
        interactor.filterNews(for: text)
    }
    
    func didClear() {
        interactor.fetchDefaultScreen()
    }
}
