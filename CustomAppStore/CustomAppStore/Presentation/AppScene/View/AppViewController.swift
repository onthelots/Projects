//
//  AppViewController.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import UIKit
import Combine
import SwiftUI

class AppViewController: UIViewController {
    
    // ViewModel 선언하기
    let viewModel: AppViewModel = AppViewModel(network: NetworkService(configuration: .default))
    
    // 구독자 선언하기
    var subscription = Set<AnyCancellable>()

    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Section Category Parameters

    // Item
    typealias Item = AppInfo

    // Section -> fetch를 통해 전체를 가져오고, Section을 나누어서 Item을 뿌리기
        enum Section: CaseIterable {
            case Books
            case Education
            case Games
            case Travel
            
            var category: String {
                switch self {
                case .Books :
                    return "Book"
                case .Education :
                    return "Education"
                case .Games :
                    return "Game"
                case .Travel :
                    return "Travel"
                }
            }
        }

    // dataSource (fetch -> addItems 메서드 -> dataSource 내 저장
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAllSections()
        configurationCollectionView()
        bind()
    }
    
    private func configurationCollectionView() {
        
        // Presentation (UICollectionCell) -> DataSource를 가지고, 보여주기
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppViewCell", for: indexPath) as? AppViewCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // Presentation (UICollectionReusableCell) -> DataSource
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                               withReuseIdentifier: "AppViewHeaderCell",
                                                                               for: indexPath) as? AppViewHeaderCell else {
                return nil
            }
            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.category)
            return header
        }
        
        // Snapshot -> Data
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.Books, .Education, .Games, .Travel])
        snapshot.appendItems([], toSection: .Books)
        snapshot.appendItems([], toSection: .Education)
        snapshot.appendItems([], toSection: .Games)
        snapshot.appendItems([], toSection: .Travel)
        dataSource.apply(snapshot)

        // layout
        self.collectionView.collectionViewLayout = layout()

//         탭 할때마다 피드백을 보여야 하므로 delegate 선언하기
//        self.collectionView.delegate = self
    }
    
    // MARK: - Layout()
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        
        
        // headerView Layout
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - 빈 datSource에 실제 데이터를 할당
    private func addItems(_ item: [AppInfo]) {
        var snapshot = dataSource.snapshot()
        
        for section in Section.allCases {
            let sectionItem = item.filter{ $0.primaryGenreName == section.category}
            if !sectionItem.isEmpty {
                snapshot.appendItems(sectionItem, toSection: section)
            }
            self.dataSource.apply(snapshot)
        }
    }
    
    // MARK: - Bind(데이터 불러오기+ dataSource에 실제 데이터 할당하기)
    private func bind() {
        
        //input (데이터 불러오기)
        viewModel.$appsBySection
            .map{ $0.values.flatMap { $0 } }
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                self?.addItems(items)
            }.store(in: &subscription)
    }
}

//extension AppViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedItem = viewModel.appsBySection.filter { <#Dictionary<Terms, [AppInfo]>.Element#> in
//            <#code#>
//        }
//        print("---> \(selectedItem.trackName)이 선택되었습니다")
//    }
//}
