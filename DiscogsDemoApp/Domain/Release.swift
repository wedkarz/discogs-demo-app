//
//  Release.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation

struct Release {
    let id: Int
    let title: String
    let year: Int
    let thumb: String
    let inWantlist: Int
    let inCollection: Int
}

extension Release {
    static var empty: Release {
        .init(id: 0, title: "Best album placeholder", year: 2000, thumb: "", inWantlist: 1000, inCollection: 100)
    }
    
    var thumbUrl: URL {
        let url = Bundle.main.url(forResource: "disc-vinyl-icon", withExtension: "png")
        return URL(string: thumb) ?? url!
    }
}

extension ReleaseDTO {
    func model() -> Release {
        Release(id: id,
                title: title,
                year: year,
                thumb: thumb,
                inWantlist: stats.community.inWantlist,
                inCollection: stats.community.inCollection)
    }
}

extension ReleaseEntity {
    func model() -> Release {
        Release(id: Int(id),
                title: title ?? "",
                year: Int(year),
                thumb: thumb ?? "",
                inWantlist: Int(inWantlist),
                inCollection: Int(inCollection))
    }
    
    func updateFromModel(_ model: Release) {
        id = Int32(model.id)
        title = model.title
        year = Int16(model.year)
        thumb = model.thumb
        inWantlist = Int32(model.inWantlist)
        inCollection = Int32(model.inCollection)
    }
}
