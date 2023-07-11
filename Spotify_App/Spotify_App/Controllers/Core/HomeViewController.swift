//
//  HomeViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/04.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSetting))
        
//        fetchData()
        fetchDataTest()
    }
    
    // New Release Album Data Fetch
    private func fetchData() {
        APICaller.shared.getNewRelease { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model) :
                    print(model)
                case .failure(let error) :
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func fetchDataTest() {        
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                
                // seeds는 genres들의 비어있는 Set으로, 5개가 될 때까지 seeds Set에 해당 데이터를 채워넣음
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                // get Recommendation
                APICaller.shared.getRecommendations(genres: seeds) { _ in
                    
                }
            case .failure(let error): break
            }
        }
    }

    // fetchData failure
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load New Release Album."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        // 중앙정렬
        label.center = view.center
    }
    
    @objc func didTapSetting() {
        let vc = SettingViewController()
        vc.title = "Setting"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
