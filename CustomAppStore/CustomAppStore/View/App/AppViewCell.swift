//
//  AppViewCell.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/05/03.
//

import UIKit
import Kingfisher

class AppViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(_ appInfo: AppInfo) {
//        self.iconImage.kf.setImage(with: URL(string: appInfo.artworkUrl100),
//                                   placeholder: UIImage(systemName: "hands.sparkles.fill"))
//        self.appName.text = appInfo.trackName
//        self.appSummary.text = appInfo.description
        
        nameLabel.text = appInfo.trackName
    }
}
