//
//  AppStore.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//
import Foundation

struct App: Codable, Hashable {
    let iconUrl: URL
    let name: String
    let description: String
}

extension App {
    enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case description = "summary"
        case iconUrl = "im:image"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        
        // Icon URL은 배열로 제공되므로, 첫 번째 이미지 URL을 선택합니다.
        let images = try container.decode([String].self, forKey: .iconUrl)
        guard let firstImageString = images.first,
              let imageUrl = URL(string: firstImageString) else {
            throw DecodingError.dataCorruptedError(forKey: .iconUrl, in: container, debugDescription: "Invalid image URL")
        }
        iconUrl = imageUrl
    }
}

