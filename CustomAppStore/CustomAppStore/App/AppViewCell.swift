//
//  AppViewCell.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/05/03.
//

import UIKit
import Kingfisher

class AppViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appSummary: UILabel!
    
    func configure(app: App) {
        self.iconImage.kf.setImage(with: app.iconUrl,
                                   placeholder: UIImage(systemName: "hands.sparkles.fill"))
        self.appName.text = app.name
        self.appSummary.text = app.description
    }
}
