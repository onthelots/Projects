//
//  AppStore.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import Foundation

// MARK: - AppStore
struct AppStore: Codable, Hashable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable, Hashable {
    let author: Author
    let entry: Entry
    let updated, rights, title, icon: Icon
    let link: [FeedLink]
    let id: Icon
}

// MARK: - Author
struct Author: Codable, Hashable  {
    let name, uri: Icon
}

// MARK: - Icon
struct Icon: Codable, Hashable  {
    let label: String
}

// MARK: - Entry (앱 세부정보)
struct Entry: Codable, Hashable  {
    let imName: Icon // 앱 이름
    let imImage: [IMImage] // 앱 아이콘 (사이즈벼례)
    let summary: Icon // 앱 정보
    let imPrice: IMPrice //
    let imContentType: IMContentType
    let rights, title: Icon
    let link: [EntryLink]
    let id: ID
    let imArtist: IMArtist
    let category: Category
    let imReleaseDate: IMReleaseDate

    enum CodingKeys: String, CodingKey {
        case imName = "im:name"
        case imImage = "im:image"
        case summary
        case imPrice = "im:price"
        case imContentType = "im:contentType"
        case rights, title, link, id
        case imArtist = "im:artist"
        case category
        case imReleaseDate = "im:releaseDate"
    }
}

// MARK: - Category
struct Category: Codable, Hashable  {
    let attributes: CategoryAttributes
}

// MARK: - CategoryAttributes
struct CategoryAttributes: Codable, Hashable  {
    let imID, term: String
    let scheme: String
    let label: String

    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
        case term, scheme, label
    }
}

// MARK: - ID
struct ID: Codable, Hashable  {
    let label: String
    let attributes: IDAttributes
}

// MARK: - IDAttributes
struct IDAttributes: Codable, Hashable  {
    let imID, imBundleID: String

    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
        case imBundleID = "im:bundleId"
    }
}

// MARK: - IMArtist
struct IMArtist: Codable, Hashable  {
    let label: String
    let attributes: IMArtistAttributes
}

// MARK: - IMArtistAttributes
struct IMArtistAttributes: Codable, Hashable  {
    let href: String
}

// MARK: - IMContentType
struct IMContentType: Codable, Hashable  {
    let attributes: IMContentTypeAttributes
}

// MARK: - IMContentTypeAttributes
struct IMContentTypeAttributes: Codable, Hashable  {
    let term, label: String
}

// MARK: - IMImage
struct IMImage: Codable, Hashable  {
    let label: String
    let attributes: IMImageAttributes
}

// MARK: - IMImageAttributes
struct IMImageAttributes: Codable, Hashable  {
    let height: String
}

// MARK: - IMPrice
struct IMPrice: Codable, Hashable  {
    let label: String
    let attributes: IMPriceAttributes
}

// MARK: - IMPriceAttributes
struct IMPriceAttributes: Codable, Hashable  {
    let amount, currency: String
}

// MARK: - IMReleaseDate
struct IMReleaseDate: Codable, Hashable  {
    let label: Date
    let attributes: Icon
}

// MARK: - EntryLink
struct EntryLink: Codable, Hashable  {
    let attributes: PurpleAttributes
    let imDuration: Icon?

    enum CodingKeys: String, CodingKey {
        case attributes
        case imDuration = "im:duration"
    }
}

// MARK: - PurpleAttributes
struct PurpleAttributes: Codable, Hashable  {
    let rel, type: String
    let href: String
    let title, imAssetType: String?

    enum CodingKeys: String, CodingKey {
        case rel, type, href, title
        case imAssetType = "im:assetType"
    }
}

// MARK: - FeedLink
struct FeedLink: Codable, Hashable  {
    let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes
struct FluffyAttributes: Codable, Hashable  {
    let rel: String
    let type: String?
    let href: String
}
