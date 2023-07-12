//
//  HomeViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/04.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    // 전체 컬렉션뷰 초기 설정 (Layout은 [CompositionalLayout] 으로 진행할 예정이며, 레이아웃의 경우 createSectionLayout(NSCollectionLayoutSection)을 반환함
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return createSectionLayout(section: sectionIndex)
        }
    )
    
    // MARK: - UIActivityIndicatorView(데이터를 불러올 동안 표시될 Spinner를 선언)
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSetting))
        
        // Configure CollectionView
        configureCollectionView()
        // spinner를 하위뷰로 추가
        view.addSubview(spinner)
        
        // Fetch API Data
        fetchData()
    }
    
    // viewDidLayoutSubViews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    
    // MARK: - ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    // MARK: - NSCollectionLayoutSection (Section의 레이아웃을 구성하는 메서드)
    // NSCollectionLayoutSize 요소들 (absoluteSize -> 항상 고정된 크기 / estimated -> 런타임 시, 크기가 변할 가능성이 있을 경우 / fractional -> 자신이 속한 컨테이너의 크기를 기반으로 비율을 설정. 0.0~1.0)
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
       
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        
        /// Vertical group in horizontal group
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 3) // 여기서의 count는, 동일한 크기의 Item을 포함하는 그룹을 생성함 -> 자동으로 계산되므로, width는 무시됨
        
        // TODO: - horizontal(layoutSize:subitem:count:) deperecated ! (나중에 Layout 코드 리팩토링 예정)
        // horizontal(layoutSize:subitem:count:)로 변경되었는데, 이는 기존과 달리 자동으로 Width가 조정되어 Count에 따라 item을 정렬시키지 않고, LayoutSize에 맞게끔 정렬시킴
        // 이는 결국, NSCollectionLayoutSize에서 설정한 widthDiemnsion을 개발자가 조정해야 함
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    
    // New Release Album Data Fetch
    private func fetchData() {
        // new Releases
        // Featured Playlists
        // Recommended Tracks
        APICaller.shared.getNewRelease { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model) :
                    print(model)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Action -> Setting Button (NavigationBar Item)
    @objc func didTapSetting() {
        let vc = SettingViewController()
        vc.title = "Setting"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

// extension to configure Layout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 컬렉션 뷰 내 섹션의 갯수
    
    // 컬렉션 뷰 내 섹션에 있는 아이템의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // 컬렉션뷰에 포함되는 cell Item의 정보
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
}





// Preview
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return UINavigationController(rootViewController: HomeViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        typealias  UIViewControllerType = UIViewController
    }
}
