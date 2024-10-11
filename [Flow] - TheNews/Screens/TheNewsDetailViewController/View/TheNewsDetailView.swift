//
//  TheNewsDetailView.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 8.10.2024.
//

import UIKit
import SnapKit

class TheNewsDetailView: UIView {
    
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundView
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let categoryHolderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = .categoryHolder
        return view
    }()
    
    private let categoryTitle: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 10, weight: .regular)
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textColor = .secondaryLabel
        view.textAlignment = .right
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        addSubview(holderView)
        holderView.addSubview(categoryHolderView)
        categoryHolderView.addSubview(categoryTitle)
        holderView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        
        holderView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(snp.trailing).offset(-12)
            make.leading.equalTo(snp.leading).offset(12)
            make.height.equalTo(200)
        }
        
        categoryHolderView.snp.makeConstraints { make in
            make.top.equalTo(holderView.snp.top).offset(12)
            make.leading.equalTo(holderView.snp.leading).offset(12)
            make.height.equalTo(30)
        }
        
        categoryTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.bottom.top.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(holderView.snp.top).offset(12)
            make.trailing.equalTo(holderView.snp.trailing).offset(-12)
        }
    }
    
    func reloadWith(_ viewModel: TheNewsDetailViewModel) {
        categoryTitle.text = viewModel.categoryName
        dateLabel.text = "\(viewModel.publishedAt)"
    }
}
