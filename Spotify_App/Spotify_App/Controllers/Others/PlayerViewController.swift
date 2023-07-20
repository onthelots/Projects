//
//  PlayerViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // imageView
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // controlsView
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        
        // delegate pattern
        controlsView.delegate = self
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        // NavigationBarButton configure
        configureBarButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeArea = view.safeAreaLayoutGuide
        // imageView
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // controllsView
        NSLayoutConstraint.activate([
            controlsView.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0),
//            controlsView.heightAnchor.cons
            controlsView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            controlsView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            controlsView.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor)
        ])
        
    }
    
    // NavigationBarButton setting(configure)
    private func configureBarButton() {
        // leftBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.down"),
            style: .done,
            target: self,
            action: #selector(didTapClose)
        )
        
        // rightBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .done,
            target: self,
            action: #selector(didTapAction)
        )
        
        // Bar Item Color
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    // MARK: - Action
    // dismiss (LeftBarButtonItem)
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    // action (LeftBarButtonItem)
    @objc private func didTapAction() {
        // Actions -> Share
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    func playControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
        //
    }
    
    func playControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        //
    }
    
    func playControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
        //
    }
}
