//
//  TheNewsTableViewCell.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 8.10.2024.
//

import UIKit
import SnapKit

class TheNewsTableViewCell: UITableViewCell {
    
    static let identifier = "TheNewsTableViewCell"
    
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundView
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textColor = .label
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private let newsImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
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
    
    private let newsDescriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        contentView.backgroundColor = .clear
        contentView.addSubview(holderView)
        holderView.addSubview(dateLabel)
        holderView.addSubview(newsImageView)
        holderView.addSubview(newsTitleLabel)
        holderView.addSubview(newsDescriptionLabel)
    }
    
    private func setupConstraints() {
        
        holderView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(6)
            make.bottom.equalTo(contentView.snp.bottom).offset(-6)
            make.left.equalTo(contentView.snp.left).offset(12)
            make.right.equalTo(contentView.snp.right).offset(-12)
            make.height.equalTo(200)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(holderView.snp.top).offset(12)
            make.leading.equalTo(holderView.snp.leading).offset(12)
        }
        
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(holderView.snp.top).offset(12)
            make.bottom.equalTo(holderView.snp.bottom).offset(-12)
            make.trailing.equalTo(holderView.snp.trailing).offset(-12)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.equalTo(holderView.snp.leading).offset(12)
            make.trailing.equalTo(newsImageView.snp.leading).offset(-12)
        }
        
        newsDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(holderView.snp.leading).offset(12)
            make.trailing.equalTo(newsImageView.snp.leading).offset(-12)
            make.bottom.equalTo(holderView.snp.bottom).offset(-12)
        }
    }
    
    func reloadWith(_ viewModel: TheHeadlineNewsViewModel) {
        dateLabel.text = viewModel.date
        newsTitleLabel.text = viewModel.title
        newsDescriptionLabel.text = viewModel.description
        
        if let imageUrl = viewModel.newsImage, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                }
            }
        }
    }
}
