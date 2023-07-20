//
//  PlayBackPresenter.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/20.
//

import Foundation
import UIKit

final class PlayBackPresenter {
    
    // Track 하나만 재생
    static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        vc.title = track.name
        vc.modalPresentationStyle = .fullScreen
        viewController.present(
            UINavigationController(rootViewController: vc),
            animated: true
        )
    }
    
    // Track 전체를 재생
    static func startPlayback(from viewController: UIViewController, track: [AudioTrack]) {
        let vc = PlayerViewController()
        vc.title = track.first?.name
        vc.modalPresentationStyle = .fullScreen
        viewController.present(
            UINavigationController(rootViewController: vc),
            animated: true
        )
    }
}
