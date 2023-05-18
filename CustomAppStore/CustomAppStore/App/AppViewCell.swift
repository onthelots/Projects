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
    
    func configure(name: String, summary: String, imageUrl: String) {
        self.iconImage.kf.setImage(with: URL(string: imageUrl),
                                   placeholder: UIImage(systemName: "hands.sparkles.fill"))
        self.appName.text = name
        self.appSummary.text = summary
    }
}
