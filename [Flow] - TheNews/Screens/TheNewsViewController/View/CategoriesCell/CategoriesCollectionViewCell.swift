//
//  CategoriesCollectionViewCell.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit
import SnapKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionViewCell"
    
    private let categoryTitleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 1
        view.textColor = .black
        view.font = .systemFont(ofSize: 15, weight: .regular)
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
        contentView.backgroundColor = UIColor.backgroundView
        contentView.addSubview(categoryTitleLabel)
        contentView.layer.cornerRadius = 15
    }
    
    private func setupConstraints() {
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.lessThanOrEqualToSuperview().inset(10)
        }
    }
    
    func reloadWith(_ viewModel: CategoriesViewModel) {
        categoryTitleLabel.text = viewModel.name
        
        if viewModel.isSelected {
            self.contentView.backgroundColor = UIColor(hex: "FF9F80")
            categoryTitleLabel.textColor = .white
        } else {
            self.contentView.backgroundColor = UIColor.backgroundView
            categoryTitleLabel.textColor = UIColor(hex: "262626")
        }
    }
}
