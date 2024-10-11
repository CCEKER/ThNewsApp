//
//  TheNewsViewModel.swift
//  TheNewsApp
//
//  Created by Cagatay Ceker on 7.10.2024.
//

import UIKit

struct TheHeadlineNewsViewModel {
    let description: String
    let title: String
    let newsImage: String?
    let date: String
}

struct CategoriesViewModel {
    let name: String
    var isSelected: Bool
}

struct SourceViewModel {
    let name: String
    let title: String
    let description: String
}

struct NavigationBarViewModel {
    var title: String
    var backgroundColor: UIColor
    var leftImage: UIImage?
    var rightImage: UIImage?
}
