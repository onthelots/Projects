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
    
    func configure(detail: Feed) {
        self.iconImage.kf.setImage(with: URL(string: detail.entry.imImage[0].label),
                                   placeholder: UIImage(systemName: "hands.sparkles.fill")) // 앱 아이콘, Placeholder
        self.appName.text = detail.entry.imName.label // 앱 이름
        self.appSummary.text = detail.entry.summary.label // 앱 요약
    }

    
}
