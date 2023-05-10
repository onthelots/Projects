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
    
    // 구독자 선언하기
    var subscription = Set<AnyCancellable>()
    
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Item
    typealias Item = App
    
    // Section -> 구조체의
    enum Section {
        case main
    }
    
    // dataSource
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch() // 첫 번째, Fetch! (Network 데이터를 가져오기)
        bind()
        configuration()
    }
    
    private func configuration() {
        // dataSource -> Presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppViewCell", for: indexPath) as? AppViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(app: item)
            return cell
        })
        
        // Snapshot -> Data
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.main])
        // 빈 배열로 snapshot을 찍어놓음
        snapshot.appendItems([], toSection: .main)
        dataSource.apply(snapshot)
        
        
        // layout
        self.collectionView.collectionViewLayout = layout()
        
        // 탭 할때마다 피드백을 보여야 하므로 delegate 선언하기
        self.collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func addItems(_ item: [App]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item, toSection: .main)
        self.dataSource.apply(snapshot)
    }
    
    private func bind() {
        //input (데이터 불러오기)
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { items in
                self.addItems(items)
            }.store(in: &subscription)
        
        //output (사용자 인터렉션)
    }
}

extension AppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        print("---> \(item)이 선택되었습니다")
    }
}
