//
//  TodayNavigationController.swift
//  AppleStore_Clone
//
//  Created by Jae hyuk Yim on 2023/04/23.
//

import UIKit

class TodayNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation -> 2 Stack
        let backArrowImage = UIImage(systemName: "arrow.backward")
        
        // navigationBar backButton 커스터마이징
        navigationBar.backIndicatorImage = backArrowImage
        navigationBar.backIndicatorTransitionMaskImage = backArrowImage
        navigationBar.tintColor = .label
        
        // NavigationTitle
        let title: String = "투데이"
        navigationItem.title = title
        
    }
}
