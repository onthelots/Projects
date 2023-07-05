//
//  SettingViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // TableView
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        
        // forCellReuseIdentifier (재사용 Cell의 Identifier) -> "cell"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // Section 세팅
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        title = "Setting"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - 📔 Section 세팅
    private func configureModels() {
        // Section 타입의 배열인 sections에 SettingModels 형식에 맞는 섹션을 추가
        // Section 1
        sections.append(Section(title: "Profile", option: [Option(title: "View Your Profile", handler: { [weak self] in
            DispatchQueue.main.async {
                // ProfileVC로 이동하는 메서드
                self?.viewProfile()
            }
        })]))
        
        // Section 2
        sections.append(Section(title: "Account", option: [Option(title: "Sign Out", handler: { [weak self] in
            DispatchQueue.main.async {
                // signOut을 실시하는 메서드
                self?.signOutTapped()
            }
        })]))
    }
    
    // VC -> Push ProfileViewController
    private func viewProfile() {
        let vc = ProfileViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func signOutTapped() {
        //
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    // MARK: - TableView
    
    // Section 갯수 -> 2개
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // Section 내 row(item)의 갯수 (각각의 section의 Index 값에 따라 달라지겠지)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].option.count
    }
    
    
    // tableView의 Cell을 나타내는 방식
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 특정 section의 Row 값
        let model = sections[indexPath.section].option[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        //TODO: - textLabel 대체 컴포넌트로 적용하기
        // cell의 라벨 -> 특정 section, row의 title로 설정
        cell.textLabel?.text = model.title
        return cell
    }
    
    // tableView -> Cell -> row를 선택했을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        
        // model
        let model = sections[indexPath.section].option[indexPath.row]
        // 해당 row의 메서드(handler())를 실행
        model.handler()
    }
    
    // Section의 Header title 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
