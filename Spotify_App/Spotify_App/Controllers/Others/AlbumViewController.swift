//
//  AlbumViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/17.
//

import UIKit

class AlbumViewController: UIViewController {

    // HomeViewController에서 Item을 didSelected할 경우, 해당 Index.item의 데이터를 할당받게 됨
    private let album: Album
    
    // Data를 받아오기 위한 Initalizer (매개변수 생성)
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        
        // HomeViewController -> didSelected한 item의 값을 album타입에 맞게 받아오고, 이를 APICaller에 위치한 getAlbumDetails 메서드의 매개변수로 할당함으로서 데이터를 할당하게 됨
        APICaller.shared.getAlbumDetails(for: album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model) :
                    break
                case .failure(let error) :
                    break
                }
            }
        }
    }

}
