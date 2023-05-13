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
struct Feed: Codable {
    let author: Author
    let entry: [Entry]
    let updated, rights, title, icon: Icon
    let link: [FeedLink]
    let id: Icon
}

// MARK: - Author
struct Author: Codable {
    let name, uri: Icon
}

// MARK: - Icon
struct Icon: Codable {
    let label: String
}

// MARK: - Entry
struct Entry: Codable {
    let imName: Icon
    let imImage: [IMImage]
    let summary: Icon
    let imPrice: IMPrice
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
struct Category: Codable {
    let attributes: CategoryAttributes
}

// MARK: - CategoryAttributes
struct CategoryAttributes: Codable {
    let imID, term: String
    let scheme: String
    let label: String

    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
        case term, scheme, label
    }
}

// MARK: - ID
struct ID: Codable {
    let label: String
    let attributes: IDAttributes
}

// MARK: - IDAttributes
struct IDAttributes: Codable {
    let imID, imBundleID: String

    enum CodingKeys: String, CodingKey {
        case imID = "im:id"
        case imBundleID = "im:bundleId"
    }
}

// MARK: - IMArtist
struct IMArtist: Codable {
    let label: String
    let attributes: IMArtistAttributes
}

// MARK: - IMArtistAttributes
struct IMArtistAttributes: Codable {
    let href: String
}

// MARK: - IMContentType
struct IMContentType: Codable {
    let attributes: IMContentTypeAttributes
}

// MARK: - IMContentTypeAttributes
struct IMContentTypeAttributes: Codable {
    let term, label: String
}

// MARK: - IMImage
struct IMImage: Codable {
    let label: String
    let attributes: IMImageAttributes
}

// MARK: - IMImageAttributes
struct IMImageAttributes: Codable {
    let height: String
}

// MARK: - IMPrice
struct IMPrice: Codable {
    let label: String
    let attributes: IMPriceAttributes
}

// MARK: - IMPriceAttributes
struct IMPriceAttributes: Codable {
    let amount, currency: String
}

// MARK: - IMReleaseDate
struct IMReleaseDate: Codable {
    let label: Date
    let attributes: Icon
}

// MARK: - EntryLink
struct EntryLink: Codable {
    let attributes: PurpleAttributes
    let imDuration: Icon?

    enum CodingKeys: String, CodingKey {
        case attributes
        case imDuration = "im:duration"
    }
}

// MARK: - PurpleAttributes
struct PurpleAttributes: Codable {
    let rel: Rel
    let type: TypeEnum
    let href: String
    let title, imAssetType: String?

    enum CodingKeys: String, CodingKey {
        case rel, type, href, title
        case imAssetType = "im:assetType"
    }
}

enum Rel: String, Codable {
    case alternate = "alternate"
    case enclosure = "enclosure"
}

enum TypeEnum: String, Codable {
    case imageJPEG = "image/jpeg"
    case textHTML = "text/html"
}

// MARK: - FeedLink
struct FeedLink: Codable {
    let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes
struct FluffyAttributes: Codable {
    let rel: String
    let type: TypeEnum?
    let href: String
}
