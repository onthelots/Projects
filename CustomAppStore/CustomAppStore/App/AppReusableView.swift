//
//  AppReusableView.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/05/03.
//

import UIKit

class AppReusableView: UICollectionReusableView {
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    func configure(title: Feed) {
        categoryTitleLabel.text = title.entry.category.attributes.label
    }
}
