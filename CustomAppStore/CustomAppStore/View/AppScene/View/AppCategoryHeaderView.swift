//
//  AppCategoryHeaderView.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/05/22.
//

import SwiftUI
import UIKit

class AppCategoryHeaderView: UICollectionReusableView {
    
    var categoryLabel = UILabel()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        categoryLabel.text = "Category"
        self.addSubview(stackView)
        stackView.addArrangedSubview(categoryLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
