//
//  LibraryViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.backgroundColor = .yellow
        
        // MARK: - paging 형식을 구현하고자, scrollView Containter View Controller를 활용
        // CollectionView를 사용하여 Paging을 사용할 시, 현재 scene화면에서 보여지지 않는 데이터 부분까지 생성되며, 이는 뷰가 매우 무거워짐
        addChildren()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 55,
            width: view.width,
            height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
        )
    }
    
    // MARK: - VC를 scrollView에 자식뷰로 할당하는 메서드
    private func addChildren() {
        addChild(playlistVC) // 1. 포함시키고자 하는 VC를 addChild로 넣어주고,
        scrollView.addSubview(playlistVC.view) // 2. ScrollView의 subView로서 view를 할당한 후
        playlistVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height) // 3. 포함하고자 하는 VC의 크기를 설정해주고
        playlistVC.didMove(toParent: self) // 포함하고자 하는 VC를 didMove 메서드를 통해 추가 혹은 삭제등의 상황에 반응할 수 있도록 함
    }
}

extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        //
    }
}
