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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImage.layer.cornerRadius = 10
    }
    
    
    func configure(_ appInfo: AppInfo) {
        self.iconImage.kf.setImage(with: URL(string: appInfo.artworkUrl100),
                                   placeholder: UIImage(systemName: "hands.sparkles.fill"))
        self.appName.text = appInfo.trackName
        self.appSummary.text = appInfo.description
    }
}
