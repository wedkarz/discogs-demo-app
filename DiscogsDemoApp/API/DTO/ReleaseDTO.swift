//
//  ReleaseDTO.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 31/12/2021.
//

import Foundation

protocol Paginated {
    var pagination: PaginationDTO { get }
}

struct ArtistReleasesDTO: Codable, Paginated {
    let pagination: PaginationDTO
    let releases: [ReleaseDTO]
}

struct ReleaseDTO: Codable {
    let id: Int
    let title: String
    let type: String
    let artist: String
    let role: String
    let resourceUrl: URL
    let year: Int
    let thumb: String
    let stats: StatsDTO
    
    enum CodingKeys: String, CodingKey {
        case resourceUrl = "resource_url"
        case id
        case title
        case type
        case artist
        case role
        case year
        case thumb
        case stats
    }
}

struct StatsDTO: Codable {
    let community: CommunityStatsDTO
}

struct CommunityStatsDTO: Codable {
    let inWantlist: Int
    let inCollection: Int
    
    enum CodingKeys: String, CodingKey {
        case inWantlist = "in_wantlist"
        case inCollection = "in_collection"
    }
}
