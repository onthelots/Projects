//
//  MainViewCell.swift
//  CustomAppStore_Test
//
//  Created by Jae hyuk Yim on 2023/05/20.
//

import UIKit

class MainViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(name: AppInfo) {
        self.nameLabel.text = name.trackName
    }
}
