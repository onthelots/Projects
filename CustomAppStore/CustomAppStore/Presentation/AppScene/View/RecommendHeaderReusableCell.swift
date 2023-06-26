//
//  RecommendHeaderReusableCell.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/06/25.
//

import UIKit

class RecommendHeaderReusableCell: UICollectionReusableView {
    
    @IBOutlet weak var testLabel: UILabel!

    func configure(_ appInfo: String) {
        testLabel.text = appInfo
    }
}
