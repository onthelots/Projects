//
//  PlayBackPresenter.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/07/20.
//

import Foundation
import UIKit

final class PlayBackPresenter {
    
    static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        viewController.present(vc, animated: true)
    }
    
    static func startPlayback(from viewController: UIViewController, track: [AudioTrack]) {
        
    }
}
