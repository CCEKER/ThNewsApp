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
    
    private let newsTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textColor = .label
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private let authorImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.tintColor = .black
        return view
    }()
    
    private let authorNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .label
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    let followButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 15
        view.backgroundColor = .selectedColor
        view.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    private lazy var authorStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [authorImageView, authorNameLabel, followButton])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 10
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
        holderView.addSubview(newsTitleLabel)
        holderView.addSubview(authorStackView)
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
        
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTitle.snp.bottom).offset(20)
            make.leading.equalTo(holderView.snp.leading).offset(12)
            make.trailing.equalTo(holderView.snp.trailing).offset(-12)
        }
        
        authorImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        followButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        authorStackView.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(24)
            make.leading.equalTo(holderView.snp.leading).offset(12)
            make.trailing.equalTo(holderView.snp.trailing).offset(-12)
            make.bottom.equalTo(holderView.snp.bottom).offset(-24)
        }
    }
    
    func reloadWith(_ viewModel: TheNewsDetailViewModel) {
        categoryTitle.text = viewModel.categoryName
        dateLabel.text = "\(viewModel.publishedAt)"
        newsTitleLabel.text = viewModel.title
        authorNameLabel.text = viewModel.author
        authorImageView.image = UIImage(systemName: "person.fill")
        followButton.setTitle(viewModel.followButtonTitle, for: .normal)
    }
}
