//
//  RecommendHeaderReusableCell.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/06/25.
//

import UIKit

class AppViewHeaderCell: UICollectionReusableView {
    
    @IBOutlet weak var testLabel: UILabel!

    func configure(_ term: String) {
        testLabel.text = term
    }
}
