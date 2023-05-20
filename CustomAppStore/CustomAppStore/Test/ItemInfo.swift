//
//  ItemInfo.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/05/20.
//

import Foundation

// MARK: - 테스트용 데이터 구조 모델
struct ItemInfo: Codable, Hashable {
    let postID: String
    let title: String
    let location: String
    let updated: TimeInterval
    let price: Int
    let numOfChats: Int
    let numOfLikes: Int
    let thumbnailURL: String
}
