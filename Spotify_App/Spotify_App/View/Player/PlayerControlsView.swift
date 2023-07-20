//
//  PlayerControlsView.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/20.
//

import Foundation
import UIKit

// PlayerControlsViewDeleagate -> 어디서 실행한다? -> 상위뷰에서 위임받아서, 내부 메서드를 구성
protocol PlayerControlsViewDelegate: AnyObject {
    func playControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
    func playControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView)
//    func playControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
//    func playControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
}

class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    // MARK: - Label & Slider & Buttons
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Label + StackView
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // trackNameLabel
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.sizeToFit()
        label.text = "TrackName"
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    // artistNameLabel
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.sizeToFit()
        label.text = "ArtistName"
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    // TODO: - iOS 15이후, UIButton 사용방식 업데이트에 따라 Button 전체 리팩토링
    // likeButton
//    private let likeButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImage(systemName: "heart")
//        button.setImage(image, for: .normal)
//        button.backgroundColor = .clear
//        button.tintColor = .systemGreen
//        return button
//    }()
    
    // MARK: - Slider
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    // MARK: - Buttons
    // Button StackView
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Play & Pause
    // pause.fill (pause image)
    private let playAndPauseButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.fill")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .label
        return button
    }()
    
    // BackwardButton
    private let backwardsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "backward.end.fill")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .label
        return button
    }()
    
    // forwardsButton
    private let forwardsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "forward.end.fill")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .label
        return button
    }()
    
    // shuffleButton
    private let shuffleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "shuffle")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .label
        return button
    }()
    
    // repeatButton
    private let repeatButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "repeat")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        verticalStackView.addArrangedSubview(labelStackView)
        verticalStackView.addArrangedSubview(volumeSlider)
        verticalStackView.addArrangedSubview(buttonStackView)
        addSubview(verticalStackView)
        
        // labelStackView
        labelStackView.addArrangedSubview(trackNameLabel)
        labelStackView.addArrangedSubview(artistNameLabel)
        
        // Buttons
        buttonStackView.addArrangedSubview(shuffleButton)
        buttonStackView.addArrangedSubview(backwardsButton)
        buttonStackView.addArrangedSubview(playAndPauseButton)
        buttonStackView.addArrangedSubview(forwardsButton)
        buttonStackView.addArrangedSubview(repeatButton)
        
        // Buttons Action
        backwardsButton.addTarget(
            self,
            action: #selector(didTapBackward),
            for: .touchUpInside
        )
        
        forwardsButton.addTarget(
            self,
            action: #selector(didTapForward),
            for: .touchUpInside
        )
        
        playAndPauseButton.addTarget(
            self,
            action: #selector(didTapPlayPause),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // veticalStackView
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    
    // Actions
    @objc func didTapBackward() {
        delegate?.playControlsViewDidTapBackwardButton(self)
    }
    
    @objc func didTapForward() {
        delegate?.playControlsViewDidTapForwardButton(self)
    }
    
    @objc func didTapPlayPause() {
        delegate?.playControlsViewDidTapPlayPause(self)
    }
}
