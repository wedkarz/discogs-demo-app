//
//  PaginationDTO.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 31/12/2021.
//

import Foundation

struct PaginationDTO: Codable {
    let perPage: Int
    let items: Int
    let page: Int
    let urls: PaginationUrlsDTO
    let pages: Int
    
    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case items
        case page
        case urls
        case pages
    }
}

struct PaginationUrlsDTO: Codable {
    let first: URL?
    let last: URL?
    let prev: URL?
    let next: URL?
}
