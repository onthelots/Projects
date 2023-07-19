//
//  SearchViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    // SearchController
    let searchController: UISearchController = {
        
        // initializer SearchController (검색 결과를 나타내는 'SearchResultViewController'가 담긴 vc를 만듬)
        let vc = UISearchController(searchResultsController: SearchResultViewController())
        vc.searchBar.placeholder = "Song, Artists, Albums"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    // collectionView
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
           
            // item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2,
                leading: 7,
                bottom: 2,
                trailing: 7
            )
            
            // group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(150)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                repeatingSubitem: item,
                count: 2
            )
            
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 0,
                bottom: 10,
                trailing: 0
            )
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
    )
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        // 검색 결과를 업데이트&담당
        searchController.searchResultsUpdater = self
        
        //configure navigationItem SearchController
        navigationItem.searchController = searchController
        
        collectionView.register(GenreCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        // collectionView delegate, dataSource
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = view.bounds
    }
    
    // Search Results
    func updateSearchResults(for searchController: UISearchController) {
        
        // query -> searchBar에 작성되는 text
        guard let resultsController = searchController.searchResultsController as? SearchResultViewController,
              let query = searchController.searchBar.text,
              // query text의 공백을 모두 제거한 이후, 비어있지 않다면(Not Empty)
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
//        resultsController.update(with: results)
        
        print(query)
        
        // Perform search
//        APICaller.shared.search
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell",
                                                            for: indexPath) as? GenreCollectionViewCell else {
            return GenreCollectionViewCell()
        }
        cell.configure(with: "Title")
        cell.backgroundColor = .systemGreen
        return cell
    }
}
