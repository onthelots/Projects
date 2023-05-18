//
//  AppStore.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//
import Foundation

// MARK: - Apps
struct Apps: Codable, Hashable {
    let apps: [AppInfo] // results

    enum CodingKeys: String, CodingKey {
        case apps = "results" // results란 명칭의 키가 존재하기 때문에, 속성 이름은 바꾸지 않거나, CodingKeys를 활용해 맞춰줘야 함
    }
}

// MARK: - AppInfo
struct AppInfo: Codable, Hashable {
    let trackName: String // 앱 이름
    let primaryGenreName: String // 앱 카테고리
    let description: String // 앱 소개
    let artworkUrl60, artworkUrl512, artworkUrl100: String // ImageURL
}
