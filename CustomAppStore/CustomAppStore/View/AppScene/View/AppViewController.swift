//
//  AppViewController.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import UIKit
import Combine

// TODO: - 카테고리별로 어플을 구분해서 사용할 수 있을까?
/*
 [ ] ViewModel -> URL Resource내 terms를 매개변수로 활용 -> Section의 값으로 할당 (현재는 단일한 main section -> 5개
 */

class AppViewController: UIViewController {
    
//     ViewModel 선언하기
    let viewModel: AppViewModel = AppViewModel(network: NetworkService(configuration: .default))

    // 구독자 선언하기
    var subscription = Set<AnyCancellable>()

    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!

    // Item
    typealias Item = AppInfo

    // Section -> 구조체의
    enum Section {
        case main
    }

    // dataSource
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch(term: .Books)
        bind()
        configuration()
    }
    
    private func configuration() {
        // Presentation (UICollectionCell) -> DataSource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppViewCell", for: indexPath) as? AppViewCell else {
                return nil
            }
            cell.configure(item)
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

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func addItems(_ item: [AppInfo]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item, toSection: .main)
        self.dataSource.apply(snapshot)
    }
    
    private func bind() {
        //input (데이터 불러오기)
        viewModel.$apps
            .receive(on: RunLoop.main)
            .sink { [unowned self] items in
                self.addItems(items)
            }.store(in: &subscription)
    }
}

extension AppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewModel.apps[indexPath.item]
        print("---> \(selectedItem.trackName)이 선택되었습니다")
    }
}