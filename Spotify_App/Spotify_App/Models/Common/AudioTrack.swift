//
//  AudioTrack.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import Foundation

struct AudioTrack: Codable {
    let artists: [Artist]
    let disc_number: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
    let album: Album?
    
    // playing audio
    let preview_url: String?
    
    // TODO: Track 시간 추가하기
//    var duration_ms: String?
}
