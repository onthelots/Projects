//
//  AppViewController.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import UIKit
import Combine

class AppViewController: UIViewController {
    
    // ViewModel 선언하기
    let viewModel: AppViewModel = AppViewModel(network: NetworkService(configuration: .default))
    
    var subscription = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Item
    typealias Item = AppStore
    
    // Section -> 모든 Section을 가져옴
    // TODO: - 동일한 Category를 Section으로 설정하는 방식을 생각해보아야 함
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch() // 첫 번째, Fetch! (Network 데이터를 가져오기)
    }
    
    func configure() {
        
        // dataSource -> Cell
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppViewCell", for: indexPath) as? AppViewCell else {
                return nil
            }
            cell.configure(detail: item)
            return cell
        })
        
//        dataSource.supplementaryViewProvider
        
        // data
        
    }
}
