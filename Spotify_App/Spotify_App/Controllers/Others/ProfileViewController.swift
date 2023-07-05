//
//  ProfileViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Profile을 나타내는 TableView
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        // 데이터(DataSource)를 얻어올 시, Hidden을 false로 변경함
        tableView.isHidden = true
        
        // forCellReuseIdentifier (재사용 Cell의 Identifier) -> "cell"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    // Mock-up------------
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        fetchProfile()
        view.backgroundColor = .systemBackground
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 뷰가 나타날 때, 상위 뷰 전체에 꽉 차도록
        tableView.frame = view.bounds
    }
    
    
    // Profile 데이터를 fetch
    func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model) :
                    self?.updateUI(with: model)
                case .failure(let error) :
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    // getCurrentUserProfile 메서드에서 data(model)을 받아오면, updateUI의 인자로 할당하여 데이터를 할당
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        
        // configure table models
        models.append("Full Name: \(model.display_name)")
        models.append("E-mail: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        
        tableView.reloadData()
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        // 중앙정렬
        label.center = view.center
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count // Row의 갯수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

