//
//  MainViewController.swift
//  CustomAppStore_Test
//
//  Created by Jae hyuk Yim on 2023/05/20.
//

import UIKit

class MainViewController: UIViewController {

    
    // NetworkService
    let networkService = NetworkService.shared
    
    // Model -> 빈 배열
    var appstoreArray: [AppInfo] = []
    
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Item, Section
    
    enum Section {
        case main
    }
    
    typealias Item = AppInfo

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // data, presentation, layout
    
    private func configuration() {
        //presentation
        dataSource = UIRollection
    }
    
    
}
