//
//  ArtistReleasesService.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Combine
import Network

final class ArtistReleasesService {
    private let onlineRepository: ArtistReleasesOnlineRepository
    private let offlineRepository: ArtistReleasesOfflineRepository
    private let networkMonitoringService: NetworkMonitoringService
    private let isConnected: CurrentValueSubject<Bool, Never> = .init(false)
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(onlineRepository: ArtistReleasesOnlineRepository, offlineRepository: ArtistReleasesOfflineRepository, networkMonitoringService: NetworkMonitoringService) {
        self.onlineRepository = onlineRepository
        self.offlineRepository = offlineRepository
        self.networkMonitoringService = networkMonitoringService
        
        networkMonitoringService.isConnectedPublisher.assign(to: \.value, on: isConnected).store(in: &disposeBag)
    }
    
    func fetch() -> AnyPublisher<[Release], Error> {
        isConnected.print().receive(on: RunLoop.main).compactMap { $0 }.withUnretained(self).flatMap { service, connected -> AnyPublisher<[Release], Error> in
            return connected ? service.fetchOnline() : service.fetchOffline()
        }
        .eraseToAnyPublisher()
    }
    
    private func fetchOffline() -> AnyPublisher<[Release], Error> {
        offlineRepository.all()
    }
    
    private func fetchOnline() -> AnyPublisher<[Release], Error> {
        return onlineRepository.all().withUnretained(self).flatMap { service, releases in
            service.offlineRepository.update(objects: releases)
        }.withUnretained(self).flatMap { service, _ in
            service.offlineRepository.all()
        }.eraseToAnyPublisher()
    }
}
