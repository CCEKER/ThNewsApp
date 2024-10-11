//
//  NewsTextField.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

class NewsTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.placeholder = "Search"
        self.backgroundColor = UIColor.backgroundView
        self.clearButtonMode = .whileEditing
        self.returnKeyType = .search
        self.keyboardType = .default
        
        let magnifyingGlassIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        magnifyingGlassIcon.contentMode = .scaleAspectFit
        magnifyingGlassIcon.tintColor = UIColor.gray
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        magnifyingGlassIcon.frame = CGRect(x: 5, y: (rightView.frame.height - 20) / 2, width: 20, height: 20)
        
        rightView.addSubview(magnifyingGlassIcon)
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 10
        return rect
    }
}
