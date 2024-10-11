//
//  TheNewsView.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit
import SnapKit

protocol TheNewsViewDelegate: AnyObject {
    func didTapSearch(text: String)
    func didClear()
}

class TheNewsView: UIView {
    
    let searchTextField = NewsTextField()
    weak var delegate: TheNewsViewDelegate?
    
    let newsCaterogiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        view.register(TheNewsTableViewCell.self, forCellReuseIdentifier: TheNewsTableViewCell.identifier)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchTextField.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        addSubview(searchTextField)
        addSubview(newsCaterogiesCollectionView)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(12)
            make.trailing.equalTo(snp.trailing).offset(-12)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.height.equalTo(50)
        }
        
        newsCaterogiesCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(12)
            make.trailing.equalTo(snp.trailing).offset(-12)
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(newsCaterogiesCollectionView.snp.bottom).offset(15)
            make.leading.equalTo(snp.leading).offset(12)
            make.trailing.equalTo(snp.trailing).offset(-12)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension TheNewsView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            delegate?.didTapSearch(text: text)
        } else {
            delegate?.didTapSearch(text: "")
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.isEmpty {
            delegate?.didClear()
        }
        return true
    }
}
