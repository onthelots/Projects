//
//  HomeViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/04.
//

import UIKit
import SwiftUI

// Section Type
enum BrowseSectionType {
    case newRelease(viewModels: [NewReleasesCellViewModel]) // 1
    case featuredPlaylists(viewModels: [NewReleasesCellViewModel]) // 2
    case recommendedTracks(viewModels: [NewReleasesCellViewModel]) // 3
}

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
    
    // Section -> 위에서 선언한 SectionType의 값을 선언
    private var sections = [BrowseSectionType]()
    
    
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
        // Register Cell
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self,
                                forCellWithReuseIdentifier: "NewReleaseCollectionViewCell")
        collectionView.register(FeaturedPlaylistsCollectionViewCell.self,
                                forCellWithReuseIdentifier: "FeaturedPlaylistsCollectionViewCell")
        collectionView.register(RecommendedTrackCollectionViewCell.self,
                                forCellWithReuseIdentifier: "RecommendedTrackCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    // New Release Album Data Fetch
    private func fetchData() {
        // API 데이터가 파싱된 이후, 레이아웃을 완성시키고자 함
        
        // Dispatch Group
        // enter : 각각의 Task를 Queue에 담을 때 호출하는 메서드
        // leave : 해당 task가 완료되었음을 알리는 메서드
        // notify : 전체 Task가 완료되었음을 알림(이후, 필요한 작업을 실시)
        let group = DispatchGroup() // 여러개의 디스패치 작업을 담당
        group.enter()
        group.enter()
        group.enter()
        print("Start fetching data")
        
        // 각각의 API Model 변수를 가져와 -> APICaller를 통해 호출된 데이터 불러오는 메서드의 model 상수에 할당함
        var newReleases: NewReleaseResponse?
        var featuredPlaylists: FeaturedPlaylistsResponse?
        var recommendedTracks: RecommendationsResponse?
        
        // new Releases
        APICaller.shared.getNewRelease { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Featured Playlists
        APICaller.shared.getFeaturedPlaylists { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                featuredPlaylists = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // Recommended Tracks
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
                    defer {
                        group.leave()
                    }
                    // seeds 데이터 할당하기
                    switch recommendedResult {
                    case .success(let model):
                        recommendedTracks = model
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // UI 이므로, Queue는 별도로 설정하지 않은 main Queue임
        group.notify(queue: .main) {
            guard let newAlbum = newReleases?.albums.items,
                  let playlists = featuredPlaylists?.playlists.items,
                  let tracks = recommendedTracks?.tracks else {
                return
            }
            // API가 정상적으로 할당되었을 때 -> configureModel 메서드(section에 model 데이터를 함께 심는 과정)를 실행함
            self.configureModels(newAlbum: newAlbum, playlists: playlists, tracks: tracks)
        }
    }
    
    // Models configure
    // 1. 임의로 만들어 둔 ViewModel (Model에서 필요한 객체만 별도로 정리)을 활용하기 위해, 각각의 Model에서의 배열 데이터들을 매개변수로 선언하고,
    // 2. section(빈 배열 형태의 타입이지만, 필요한 데이터를 매개변수로 가지고 있는)에서 활용할 수 있는 데이터를 매개변수에서 하나씩 뽑아서 section 배열에 할당하는 로직을 만듬
    // 3. 그렇게 되면, 위 fetchData 메서드에서 받아오는 API 데이터들을 활용하여 section 빈 배열에 실제 데이터를 할당할 수 있음
    private func configureModels(newAlbum: [Album],
                                 playlists: [Playlist],
                                 tracks: [AudioTrack]) {
        
        sections.append(.newRelease(viewModels: newAlbum.compactMap({ item in
            return NewReleasesCellViewModel(name: item.name,
                                            artworkURL: URL(string: item.images.first?.url ?? ""),
                                            numberOfTracks: item.total_tracks,
                                            artistName: item.artists.first?.name ?? "unknown")
        })))
        sections.append(.featuredPlaylists(viewModels: []))
        sections.append(.recommendedTracks(viewModels: []))
        collectionView.reloadData()
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    // 컬렉션 뷰 내 섹션에 있는 아이템의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // type은 sections 타입 중, Index에 따른 section의 모든 경우의 수를 받아옴
        let type = sections[section]
        
        // 이후, section 별로 Item의 갯수를 각각 다르게 반환함
        switch type {
        case .newRelease(viewModels: let viewModels):
            return viewModels.count
        case .featuredPlaylists(viewModels: let viewModels):
            return viewModels.count
        case .recommendedTracks(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    // 컬렉션뷰에 포함되는 cell Item의 정보
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // type은 sections 타입 중, Index에 따른 section의 모든 경우의 수를 받아옴
        let type = sections[indexPath.section]
        
        switch type {
            
        case .newRelease(viewModels: let viewModels) :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier,
                                                          for: indexPath) as? NewReleaseCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.item]
            cell.configure(with: viewModel)
            return cell
            
        case .featuredPlaylists(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.identifier,
                                                          for: indexPath) as? FeaturedPlaylistsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.item]
            cell.backgroundColor = .blue
            return cell
            
        case .recommendedTracks(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier,
                                                          for: indexPath) as? RecommendedTrackCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.item]
            cell.backgroundColor = .orange
            return cell
        }
    }
    
    // MARK: - NSCollectionLayoutSection (Section의 레이아웃을 구성하는 메서드)
    // NSCollectionLayoutSize 요소들 (absoluteSize -> 항상 고정된 크기 / estimated -> 런타임 시, 크기가 변할 가능성이 있을 경우 / fractional -> 자신이 속한 컨테이너의 크기를 기반으로 비율을 설정. 0.0~1.0)
    // TODO: - horizontal(layoutSize:subitem:count:) deperecated ! (나중에 Layout 코드 리팩토링 예정)
    // horizontal(layoutSize:subitem:count:)로 변경되었는데, 이는 기존과 달리 자동으로 Width가 조정되어 Count에 따라 item을 정렬시키지 않고, LayoutSize에 맞게끔 정렬시킴
    // 이는 결국, NSCollectionLayoutSize에서 설정한 widthDiemnsion을 개발자가 조정해야 함
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0 :
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            
            // Vertical group in horizontal group
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .absolute(390))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                                 subitem: item,
                                                                 count: 3)
        
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                             heightDimension: .absolute(390))
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize,
                                                                     subitem: verticalGroup,
                                                                     count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
            
        case 1 :
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
                                                  heightDimension: .absolute(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Group
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
                                                             heightDimension: .absolute(400))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                                     subitem: item,
                                                                     count: 2)
            
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
                                                             heightDimension: .absolute(400))
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize,
                                                                     subitem: verticalGroup,
                                                                     count: 1)
            // Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
            
        case 2 :
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            
            // Vertical group in horizontal group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .absolute(80))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                                 subitem: item,
                                                                 count: 1)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            
            return section
            
        default :
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(390))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitem: item,
                                                         count: 1)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
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
