//
//  ArtistReleasesRepository.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak on 02/01/2022.
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Combine
import Moya
import CombineMoya
import CoreData
import SwiftUI

class ArtistReleasesOnlineRepository: Repository {
    typealias ItemType = Release
    
    private let discogsProvider: MoyaProvider<DiscogsAPIService>
    
    init(discogsProvider: MoyaProvider<DiscogsAPIService> = .init()) {
        self.discogsProvider = discogsProvider
    }
    
    func all() -> AnyPublisher<[ItemType], Error> {
        discogsProvider.requestPublisher(.artistReleases(id: DiscogsServiceConstants.Artist.theDoors))
            .filterSuccessfulStatusCodes()
            .map(ArtistReleasesDTO.self)
            .map(\.releases)
            .map { $0.map { release in release.model() } }
            .mapError { $0 as Error }
            .print()
            .eraseToAnyPublisher()
    }
    
    func update(objects: [ItemType]) -> AnyPublisher<Void, Error> {
        Fail(error: RepositoryError.readonly).eraseToAnyPublisher()
    }
}
