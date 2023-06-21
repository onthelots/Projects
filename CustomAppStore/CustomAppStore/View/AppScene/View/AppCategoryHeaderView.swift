//
//  AppCategoryHeaderView.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/05/22.
//

import UIKit

class AppCategoryHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var categoryLabel: UILabel!
    
    func configure(_ appInfo: AppInfo) {
        categoryLabel.text = appInfo.primaryGenreName
    }
}
