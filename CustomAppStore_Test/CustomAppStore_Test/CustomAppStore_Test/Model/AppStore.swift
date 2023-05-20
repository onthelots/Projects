//
//  AppStore.swift
//  CustomAppStore_Test
//
//  Created by Jae hyuk Yim on 2023/05/20.
//

import Foundation

// MARK: - AppStore 모델

// MARK: - Apps
struct Apps: Codable {
    let apps: [AppInfo]

    enum CodingKeys: String, CodingKey {
        case apps = "results" // results란 명칭의 키가 존재하기 때문에, 속성 이름은 바꾸지 않거나, CodingKeys를 활용해 맞춰줘야 함
    }
}

// MARK: - AppInfo
struct AppInfo: Codable {
    let trackName: String
    let primaryGenreName: String
    let description: String
    let artworkUrl60, artworkUrl512, artworkUrl100: String
}
