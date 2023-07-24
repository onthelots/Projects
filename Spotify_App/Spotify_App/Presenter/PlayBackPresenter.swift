//
//  PlayBackPresenter.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/20.
//

import AVFoundation
import Foundation
import UIKit

// Delegate Pattern
protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
 }

final class PlayBackPresenter {
    
    static let shared = PlayBackPresenter()
    
    // 3️⃣startPlayback 메서드를 실행할 때 마다, 아래 track, tracks 데이터가 할당이 됨
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    // tracks의 index를 확인하기 위한 임의 변수
    var index: Int = 0
    
    // delegate?
    var playerVC: PlayerViewController?
    
    
    // MARK: - Audio Player
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer? // playlist or album Player
    
    // 3️⃣현재 트랙 : 저장 프로퍼티 (하나의 track이냐, 아니면 앨범, 플레이리스트 전체의 Tracks이냐)
    var currentTrack: AudioTrack? {
        // 전체 재생이 아닐 경우, track만을 반환함
        if let track = track, tracks.isEmpty {
            return track
            // 전체 재생일 경우(tracks가 비어있지 않을 경우), 현재 재생되는 Track을 반환해야 함
            // tracks일 경우에는 반드시 AVplayer의 유형을 결정해줘야 함 (여기서는 앨범 혹은 플레이리스트니까, playerQueue일 경우에만 저장되도록 함)
        }
        else if !tracks.isEmpty {
            // didTapFoward에서 index 값을 할당함 (
            return tracks[index]
        }
        
        return nil
    }
    
    // Track 하나만 재생
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        
        // 1️⃣ track이 하나이므로, tracks는 빈 배열로 (currentTrack의 값을 설정해주기 위해)
        self.track = track
        self.tracks = []
        
        self.player?.volume = 0.0
        self.player?.play()
        
        let vc = PlayerViewController()
        vc.title = track.name
        vc.modalPresentationStyle = .fullScreen
        
        // dataSource (vc, playerViewController에서 선언한 weak 유형/PlayerDataSource 프로토콜 타입의 dataSource를 해당 Preseneter에서 위임받음
        vc.dataSource = self
        
        // delegate -> playerControlsView에 위치한 버튼들의 실제 '액션을 정의'해주기 위해 위임받음
        vc.delegate = self
        
        viewController.present(
            UINavigationController(rootViewController: vc),
            animated: true
        )
        
        self.playerVC = vc
    }
    
    // Track 전체를 재생
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        
        // 1️⃣ track이 여러개인 traks이므로, track은 nil값으로 (currentTrack의 값을 설정해주기 위해)
        
        if tracks.count == 1 {
            if let track = tracks.first {
                self.track = track
                self.tracks = []
                
                guard let url = URL(string: track.preview_url ?? "") else {
                    return
                }
                player = AVPlayer(url: url)
                
                self.player?.volume = 0.05
                self.player?.play()
                
                let vc = PlayerViewController()
                vc.title = track.name
                vc.modalPresentationStyle = .fullScreen
                
                vc.dataSource = self
                vc.delegate = self
                
                viewController.present(
                    UINavigationController(rootViewController: vc),
                    animated: true
                )
                
                self.playerVC = vc
            }
        } else {
            self.tracks = tracks
            self.track = nil
            
            self.playerQueue = AVQueuePlayer(items: tracks.compactMap({ items in
                guard let url = URL(string: items.preview_url ?? "") else {
                    return nil
                }
                return AVPlayerItem(url: url)
            }))
            
            self.playerQueue?.volume = 0.05
            self.playerQueue?.play()
            
            let vc = PlayerViewController()
            vc.title = tracks.first?.name
            vc.modalPresentationStyle = .fullScreen
            // 2️⃣ PlayerViewController에서 선언한 PlayerDataSource타입의 dataSource 객체는, 여기(self) PlayerBackPresenter에서 extension을 통해
            // 선언된 값에서 담당함 (즉, 이미 위에서 선언한 currentTrack 객체의 데이터가 존재하니, 프로토콜 프로퍼티들의 값을 할당시켜줄 수 있음)
            vc.dataSource = self
            vc.delegate = self
            
            viewController.present(
                UINavigationController(rootViewController: vc),
                animated: true
            )
            
            self.playerVC = vc
        }
    }
}

// 4️⃣ playerDataSource protocol 타입 내 정의된 프로퍼티를, 현재 PlayBackPresenter extension을 통해 데이터를 할당할 수 있도록 함
extension PlayBackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "https://picsum.photos/id/237/200/300")
    }
}

// MARK: - 프로토콜 playerControllerDelegate 내 메서드를 정의
extension PlayBackPresenter: PlayerControllerDelegate {
    
    // PlayPause 기능 정의
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        playerVC?.refreshUI()
    }
    
    // didTapFoward 기능 정의
    func didTapFoward() {
        if tracks.isEmpty {
            player?.pause()
        }
        
        // tracks(items)의 첫번째 트랙
        else if let player = playerQueue {
            // 마지막 인덱스를 초과할 경우, 0으로 다시 수렴하도록 함
            // 처음 didTapFoward 함수를 실행했을 땐 1이며, 지속적으로 증가하다가 tracks의 숫자와 동일해졌을 때 다시 0으로
            self.index = (index + 1) % tracks.count
            player.advanceToNextItem()
            player.pause() // 다음 트랙을 재생하기 전, 현재 재생중인 트랙을 정지
        }
        playerVC?.refreshUI()
    }
    
    // didTapBackward 기능 정의
    func didTapBackward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.seek(to: .zero)
            player?.play()
        }
        else if let player = playerQueue {
            if index > 0 {
                index -= 1
                player.seek(to: .zero)
                print(index)
            } else {
                player.seek(to: .zero)
                player.pause()
                player.play()
                print(index)
            }
        }
        playerVC?.refreshUI()
    }
    
    // slider의 value는 player의 Volume 값으로 설정
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}
