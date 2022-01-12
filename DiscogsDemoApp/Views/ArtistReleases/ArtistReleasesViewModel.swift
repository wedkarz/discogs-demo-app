//
//  ArtistReleasesViewModell.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Combine

enum ArtistReleasesViewModelOutput {
    case initial
    case loading(placeholder: [Release])
    case loaded(items: [Release])
    case error(Error)
    case empty
}

final class ArtistReleasesViewModel: ObservableObject {
    @Published var releases: [Release] = []
    @Published var output: ArtistReleasesViewModelOutput = .initial
    
    private let service: ArtistReleasesService
    private var disposeBag = Set<AnyCancellable>()
    
    init(service: ArtistReleasesService) {
        self.service = service
    }
    
    func fetch() {
        output = .loading(placeholder: (0 ..< 10).map { Release.empty(id: $0) })
        
        service.fetch().sink { [weak self] completion in
            guard case let .failure(error) = completion else { return }
            self?.output = .error(error)
        } receiveValue: { [weak self] value in
            self?.output = value.isEmpty ? .empty : .loaded(items: value)
        }.store(in: &disposeBag)
    }
}
