//
//  FeaturedPlaylistsCollectionViewCell.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/13.
//

import UIKit

class FeaturedPlaylistsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistsCollectionViewCell"
    
    // Component 1. albumCoverImage
    private let playlistCoverImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Component 2. albumLabel + TextStyle (for dynamic type)
    private let playlistNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    // Component 3. artistNameLabel + TextStyle (for dynamic type)
    private let creatorNameLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // ContentView 기본 Layout 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        // addSubview(components)
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        
        // SuperView 밖으로 넘어가는 subview는 잘릴 수 있음
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // SubView Layout 설정
    override func layoutSubviews() {
        super.layoutSubviews()
    
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 재사용 되기전에 초기화
        playlistCoverImageView.image = nil
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
    }
    
    // 각각의 컴포넌트에 FeaturedPlaylistsCellViewModel 타입의 데이터를 매개변수값으로 할당함
    func configure(with viewModel: FeaturedPlaylistsCellViewModel) {
        playlistCoverImageView.kf.setImage(with: viewModel.artworkURL)
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
    }
}
