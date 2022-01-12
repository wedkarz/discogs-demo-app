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
        isConnected.removeDuplicates().compactMap { $0 }.flatMap { [unowned self] connected in
            connected ? self.fetchOnline() : self.fetchOffline()
        }.eraseToAnyPublisher()
    }
    
    private func fetchOffline() -> AnyPublisher<[Release], Error> {
        offlineRepository.all()
    }
    
    private func fetchOnline() -> AnyPublisher<[Release], Error> {
        return onlineRepository.all().flatMap { [unowned self] releases in
            self.offlineRepository.update(objects: releases)
        }.flatMap { [unowned self] _ in
            self.offlineRepository.all()
        }.eraseToAnyPublisher()
    }
}
