//
//  AppStore.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import Foundation

struct Feed: Codable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let updated: String
    let results: [App]
}

struct Author: Codable {
    let name: String
    let uri: String
}

struct Link: Codable {
    let linkSelf: String
    let alternate: String
}

struct App: Codable {
    let name: String
    let id: String
    let artistName: String
    let artistUrl: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case id = "id"
        case artistName = "im:artist"
        case artistUrl = "im:artist.attributes.href"
        case artworkUrl100 = "im:image.2.label"
        case genres = "category"
        case url = "link.attributes.href"
    }
}

struct Genre: Codable {
    let genreId: String
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case genreId = "attributes.id"
        case name = "attributes.label"
        case url = "attributes.scheme"
    }
}
